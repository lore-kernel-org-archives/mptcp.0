Content-Type: multipart/mixed; boundary="===============3746867691494404593=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [MPTCP][PATCH v5 mptcp-next 0/3] move to next addr and
 testcases
Date: Tue, 23 Feb 2021 17:01:00 +0100
Message-ID: <098ff8e4-0713-a2d5-9285-4ff2402df39b@tessares.net>
In-Reply-To: cover.1613703548.git.geliangtang@gmail.com
X-Status: 
X-Keywords:                  
X-UID: 7922

--===============3746867691494404593==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Geliang, Mat,

On 19/02/2021 04:08, Geliang Tang wrote:
> v5:
>   - rename lookup_anno_list_by_saddr to mptcp_lookup_anno_list_by_saddr.
> =

> v4:
>   - use lookup_anno_list_by_saddr instead of lookup_subflow_by_saddr.
>   - use MPTCP_PM_SUBFLOW_ESTABLISHED instead of MPTCP_PM_ESTABLISHED.
> =

> v3:
>   - drop MPTCP_PM_NEXT_ADDR, use MPTCP_PM_ESTABLISHED instead.
>   - hold the msk lock in mptcp_pm_add_addr_echoed.
>   - tag: export/20210209T062213
> =

> v2:
>   - add patch 2 and 3 for removing testcases.
>   - tag: export/20210207T062839.

Thank you for the patches and reviews!

With a bit of delay, sorry for that, it is now at the end of our tree =

with Mat's RvB tag:

- 4877b4409cd8: mptcp: export lookup_anno_list_by_saddr
- 57e57640c326: mptcp: move to next addr when subflow creation fail
- 608768e00068: selftests: mptcp: signal addresses testcases
- Results: 08fd790ee3b7..8d9171e1a9d2

Tests + export are in progress!

> Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/151

I didn't close this issue because there are other patches in review =

linked to this issue.

Cheers,
Matt
-- =

Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
--===============3746867691494404593==--
