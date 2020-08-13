Content-Type: multipart/mixed; boundary="===============5811938961771407067=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [MPTCP][PATCH v6 mptcp-next 0/2] Add REMOVE_ADDR support
Date: Thu, 13 Aug 2020 08:48:40 +0200
Message-ID: <aa5f39c1e794688a31e703b1ce5623f2d67ec1d5.camel@redhat.com>
In-Reply-To: cover.1597136641.git.geliangtang@gmail.com
X-Status: 
X-Keywords:                  
X-UID: 5542

--===============5811938961771407067==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Tue, 2020-08-11 at 17:34 +0800, Geliang Tang wrote:
> v6:
>  - rename lookup_anno_list_by_saddr to remove_anno_list_by_saddr as
>    Paolo suggested.
>  - add msk socket lock when traverse msk->conn_list as Paolo suggested.
>  - Since the first three patches in v5 have been merged to export
>    branch, drop them from this patchset.
>  - add remove addr and subflow selftest test case.
>  - this patchset is against mptcp_net-next's export branch.

Thank you for the great work. =


I'm currently on PTO, and likely will not able to review it till aug
24. Hopefully someone else will step-in before :)

Cheers,

Paolo



--===============5811938961771407067==--
