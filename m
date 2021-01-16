Content-Type: multipart/mixed; boundary="===============0477178936543499417=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [MPTCP][PATCH v10 mptcp-next 0/9] ADD_ADDR: ports support
Date: Sat, 16 Jan 2021 12:11:50 +0100
Message-ID: <64b2d3b3-facf-95da-24f4-f695aedaefe3@tessares.net>
In-Reply-To: 05257ea0-f26d-2855-243d-59597cc83895@tessares.net
X-Status: 
X-Keywords:                  
X-UID: 7408

--===============0477178936543499417==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On 16/01/2021 12:10, Matthieu Baerts wrote:
> Hi Geliang, Mat,
> =

> On 15/01/2021 02:18, Mat Martineau wrote:
>> On Thu, 14 Jan 2021, Geliang Tang wrote:
>>
>>> v10:
>>> - use &w->rwork in mptcp_pm_free_addr_entry instead of casting w
>>> - rebase on export/20210113T185637
>>> - please apply this patchset after the following patchsets:
>>> =C2=A0=C2=A0 add IPv4-mapped address support (v5)
>>> =C2=A0=C2=A0 mptcp: create subflow for newly added address and testcase=
s (v5)
>>>
>>
>> v10 looks ready for the export branch. Thanks for the fixes!
> =

> Thank you for the nice new feature and reviews!
> =

> Just added in our repo with Mat's RvB tags (and one typo detected by =

> "checkpatch.pl --codespell").

(I forgot the refs, just in case)

- 439600160048: mptcp: create the listening socket for new port
- 3122c6542e4f: mptcp: drop unused skb in subflow_token_join_request
- 9dfc9b337d4f: mptcp: add a new helper subflow_req_create_thmac
- 551edb8d92ab: mptcp: add port number check for MP_JOIN
- 3f96f48fbd19: mptcp: enable use_port when invoke addresses_equal
- 60e993388f4f: mptcp: deal with MPTCP_PM_ADDR_ATTR_PORT in PM netlink
- 7e876f36d164: selftests: mptcp: add port argument for pm_nl_ctl
- e7b4ca22e5fb: mptcp: add the mibs for ADD_ADDR with port
- 4eed52217818: selftests: mptcp: add testcases for ADD_ADDR with port
- Results: 2535f605affc..5f5277ef3bf4

Cheers,
Matt
-- =

Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
--===============0477178936543499417==--
