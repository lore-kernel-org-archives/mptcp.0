Content-Type: multipart/mixed; boundary="===============7318560212293507218=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [MPTCP][PATCH v5 mptcp-next 0/5] mptcp: create subflow
 for newly added address and testcases
Date: Sat, 16 Jan 2021 11:36:24 +0100
Message-ID: <24a8ad97-5306-123f-c279-be3ef0c0e548@tessares.net>
In-Reply-To: 912d998d-c12a-d9d3-8521-31887536f374@linux.intel.com
X-Status: 
X-Keywords:                  
X-UID: 7406

--===============7318560212293507218==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Geliang, Mat,

On 15/01/2021 01:28, Mat Martineau wrote:
> On Thu, 14 Jan 2021, Geliang Tang wrote:
> =

>> v5:
>> - rebase on export/20210113T185637
>> - please apply this patchset after the following patchset:
>> =C2=A0=C2=A0 add IPv4-mapped address support (v5)
>>
> =

> Series looks good for the export branch.

Thank you for these patches and reviews!

I just added them to our repo, with Mat's RvB and switched commit =

messages from past form ("This patch did (...)") to present form ("This =

patch does (...)").

- 309109005244: mptcp: use WRITE_ONCE/READ_ONCE for the pernet *_max
- b625ee82d5ce: mptcp: drop *_max fields in mptcp_pm_data
- 884ca432dee1: mptcp: create subflow or signal addr for newly added address
- d322efc74040: selftests: mptcp: use minus values for removing address =

numbers
- 9f64c27e4520: selftests: mptcp: add testcases for newly added addresses
- Results: 46973a057ea7..82d1465d7875

> Thanks for rebasing and the patch dependency information!

Indeed, very useful!

(...)

>> Address issue 19 "let PM netlink update live sockets on local addresses
>> list change". The removed addresses part of this issue is done, this
>> patchset only implemented the added addresses part.
>>
>> Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/19

Thanks for the link!

Feel free to also add that in the description of the specific commit =

fixing the issue. This allows Github to close the issue automatically =

and track where the commit is, e.g. in our export, in other repos, etc.

- 27a53350dba7: tg:msg: add Closes tag

(But don't worry if you forget, we all do :-) )

Tests + export are in progress!

Cheers,
Matt
-- =

Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
--===============7318560212293507218==--
