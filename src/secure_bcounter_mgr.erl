%% -------------------------------------------------------------------
%%
%% Copyright <2013-2018> <
%%  Technische Universität Kaiserslautern, Germany
%%  Université Pierre et Marie Curie / Sorbonne-Université, France
%%  Universidade NOVA de Lisboa, Portugal
%%  Université catholique de Louvain (UCL), Belgique
%%  INESC TEC, Portugal
%% >
%%
%% This file is provided to you under the Apache License,
%% Version 2.0 (the "License"); you may not use this file
%% except in compliance with the License.  You may obtain
%% a copy of the License at
%%
%%   http://www.apache.org/licenses/LICENSE-2.0
%%
%% Unless required by applicable law or agreed to in writing,
%% software distributed under the License is distributed on an
%% "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
%% KIND, either expressed or implied.  See the License for the
%% specific language governing permissions and limitations
%% under the License.
%%
%% List of the contributors to the development of Antidote: see AUTHORS file.
%% Description and complete License: see LICENSE file.
%% -------------------------------------------------------------------

%% Module for handling secure bounded counter operations.

-module(secure_bcounter_mgr).

-export([generate_downstream/3]).

-define(DATA_TYPE, antidote_crdt_counter_b_secure).


%% ===================================================================
%% Public API
%% ===================================================================

%% @doc Processes an increment operation for the bounded counter.
generate_downstream(_Key, {increment, {Amount, NSquare}}, SecureBCounter) ->
    MyDCId = dc_utilities:get_my_dc_id(),
    ?DATA_TYPE:downstream({increment, {Amount, NSquare, MyDCId}}, SecureBCounter);
generate_downstream(_Key, {increment, Amount}, SecureBCounter) ->
    MyDCId = dc_utilities:get_my_dc_id(),
    ?DATA_TYPE:downstream({increment, {Amount, MyDCId}}, SecureBCounter);

%% @doc Processes a decrement operation for a secure bounded counter.
generate_downstream(_Key, {decrement, {Amount, NSquare}}, SecureBCounter) ->
    MyDCId = dc_utilities:get_my_dc_id(),
    ?DATA_TYPE:downstream({decrement, {Amount, NSquare, MyDCId}}, SecureBCounter);
generate_downstream(_Key, {decrement, Amount}, SecureBCounter) ->
    MyDCId = dc_utilities:get_my_dc_id(),
    ?DATA_TYPE:downstream({decrement, {Amount, MyDCId}}, SecureBCounter);

%% @doc Processes a trasfer operation between two owners of the
%% counter.
generate_downstream(_Key, {transfer, {Amount, To, From}}, SecureBCounter) ->
    ?DATA_TYPE:downstream({transfer, {Amount, To, From}}, SecureBCounter).
