Content-Type: multipart/mixed; boundary="===============2364838792445440661=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [MPTCP][PATCH v10 mptcp-next 0/9] ADD_ADDR: ports support
Date: Sat, 16 Jan 2021 12:10:38 +0100
Message-ID: <05257ea0-f26d-2855-243d-59597cc83895@tessares.net>
In-Reply-To: 5b9c3311-f141-fd3-c6d-1cb425f844a2@linux.intel.com
X-Status: 
X-Keywords:                  
X-UID: 7407

--===============2364838792445440661==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Geliang, Mat,

On 15/01/2021 02:18, Mat Martineau wrote:
> On Thu, 14 Jan 2021, Geliang Tang wrote:
> =

>> v10:
>> - use &w->rwork in mptcp_pm_free_addr_entry instead of casting w
>> - rebase on export/20210113T185637
>> - please apply this patchset after the following patchsets:
>> =C2=A0=C2=A0 add IPv4-mapped address support (v5)
>> =C2=A0=C2=A0 mptcp: create subflow for newly added address and testcases=
 (v5)
>>
> =

> v10 looks ready for the export branch. Thanks for the fixes!

Thank you for the nice new feature and reviews!

Just added in our repo with Mat's RvB tags (and one typo detected by =

"checkpatch.pl --codespell").

Tests + export are in progress!

Cheers,
Matt
-- =

Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
--===============2364838792445440661==--
