Content-Type: multipart/mixed; boundary="===============4862063379548606616=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [MPTCP][PATCH v5 mptcp-next 0/4] Add REMOVE_ADDR support
Date: Thu, 06 Aug 2020 20:33:04 +0200
Message-ID: <3fa8ca3b-58f4-6a6f-ca00-49d034ee3e83@tessares.net>
In-Reply-To: cover.1596534832.git.geliangtang@gmail.com
X-Status: 
X-Keywords:                  
X-UID: 5502

--===============4862063379548606616==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Geliang, Paolo,

On 04/08/2020 12:01, Geliang Tang wrote:
> v5:
>   - merge mptcp_nl_remove_subflow() and mptcp_nl_remove_addr()
>   - add cond_resched
>   - reduce the indentation level in mptcp_pm_nl_rm_addr_received
> =

> v4:
>   - update mptcp_subflow_shutdown()'s args.
>   - add rm_id check to make sure we don't shutdown the first subflow.
>   - add conn_list empty check.
>   - move anno_list to mptcp_pm_data.
>   - add a new patch 'mptcp: add remove subflow support'.
> =

> v3:
>   - fix memory leak and lock issue in v2.
>   - drop alist in v2.
>   - fix mptcp_subflow_shutdown's arguments.
>   - bzero remote in mptcp_pm_create_subflow_or_signal_addr.
>   - add more commit message.
> =

> Geliang Tang (4):
>    mptcp: rename addr_signal and the related functions
>    mptcp: add the outgoing RM_ADDR support
>    mptcp: add the incoming RM_ADDR support
>    mptcp: remove addr and subflow in PM netlink

Thank you for the patches and the reviews!

I just added these patches except the last one in the "export" branch.

Tests are still green!

Cheers,
Matt
-- =

Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
--===============4862063379548606616==--
