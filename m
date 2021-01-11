Content-Type: multipart/mixed; boundary="===============3928664362153876964=="
MIME-Version: 1.0
From: Mat Martineau <mathew.j.martineau at linux.intel.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [MPTCP][PATCH mptcp-next] selftests: mptcp: add command
 line arguments for mptcp_join.sh
Date: Mon, 11 Jan 2021 15:44:49 -0800
Message-ID: <af44b35e-91cb-aabe-8cdc-ea86d9f4a2e1@linux.intel.com>
In-Reply-To: CA+WQbwuLSRnODw4tKS3enehTDZU8XX0bidfWRaxJyp_VDeQn4A@mail.gmail.com
X-Status: 
X-Keywords:                  
X-UID: 7315

--===============3928664362153876964==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Sat, 9 Jan 2021, Geliang Tang wrote:

> Hi Mat,
>
> Mat Martineau <mathew.j.martineau(a)linux.intel.com> =E4=BA=8E2021=E5=B9=
=B41=E6=9C=889=E6=97=A5=E5=91=A8=E5=85=AD =E4=B8=8A=E5=8D=889:25=E5=86=99=
=E9=81=93=EF=BC=9A
>>
>>
>> On Tue, 5 Jan 2021, Geliang Tang wrote:
>>
>>> Since the mptcp_join script is becoming too big, this patch split it in=
to
>>> several smaller trunks, each of them has been defined in a function as a
>>> individual test group for several related testcases.
>>>
>>> Using bash getopts function to parse command line arguments, and involk
>>> each function to do the individual test group.
>>>
>>> Here are all the arguments:
>>>  -f subflows_tests
>>>  -s signal_address_tests
>>>  -l link_failure_tests
>>>  -t add_addr_timeout_tests
>>>  -r remove_tests
>>>  -a add_tests
>>>  -6 ipv6_tests
>>>  -4 v4mapped_tests
>>>  -b backup_tests
>>>  -p add_addr_ports_tests
>>>  -c syncookies_tests
>>>  -h help
>>>
>>> Run mptcp_join.sh with no argument will do all the testcases.
>>>
>>
>> This seems like a good idea to me, but what patchset(s) do I need to app=
ly
>> first?
>>
>
> Sorry, here is the commit log with all my patches against
> export/20210108T061525:
>
> ---
>
> commit 25b58355f5ad79c2a623179060730b6b77d53cb2
> Author: Geliang Tang <geliangtang(a)gmail.com>
> Date:   Fri Dec 25 14:16:19 2020 +0800
>

...

>


Hi Geliang -

I tried to reproduce the history you listed, and 'git am' still gets stuck =

based on the most recent patch series in patchwork. I resolved one minor =

conflict (just context) in "mptcp: drop *_max fields in mptcp_pm_data", =

and then "ADD_ADDR: ports support" series applied ok.

But then this patch ("selftests: mptcp: add command line arguments for =

mptcp_join.sh") failed, and at this point I would just prefer to have all =

these series reposted on the mailing list so we know they apply cleanly:

v5  - mptcp: create subflow for newly added address and testcases
v10 - ADD_ADDR: ports support (also include the minor fix requested)
v2  - selftests: mptcp: add command line arguments for mptcp_join.sh
v2  - add add_addr_urgent


I apply each series to a local git workspace before reviewing so I can see =

the changes in context with all the other code, and to be able to build =

and test. I'll continue reviewing when everything easily applies - and =

that way everything will be ready for the topgit tree too.


> The first three patches (IPv4mapped patchset) should be sent by Matt, I
> only added them in the attachment.

Based on the conflict I found, it seems like there are local changes that =

aren't part of the posted v4 for that IPv4mapped patch set.


Thanks!

--
Mat Martineau
Intel

--===============3928664362153876964==--
