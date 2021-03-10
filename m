Content-Type: multipart/mixed; boundary="===============1432304300387125961=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [MPTCP][PATCH v3 mptcp-next] Squash to "mptcp: add
 rm_list in mptcp_out_options" - bugfix
Date: Wed, 10 Mar 2021 15:04:03 +0100
Message-ID: <d2a39f62-7295-9ba6-9f6f-1fb16b4ae3ad@tessares.net>
In-Reply-To: 1013371d28c0219e3bdd904539094a90d7d3ffae.1615260023.git.geliangtang@gmail.com
X-Status: 
X-Keywords:                  
X-UID: 8091

--===============1432304300387125961==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Geliang, Mat

On 09/03/2021 04:30, Geliang Tang wrote:
> The original RM_ADDR option writing can only deal with 8 addresses, this
> patch fixed it.
> =

> It also fixed a bug in mptcp_rm_addr_len too.

Thank you for the patch and the review!

- aa3d2ca0ec3a: "squashed" in "mptcp: add rm_list in mptcp_out_options"
- Results: 0d134d561988..6944cd8f9fbe

Tests + export have been queued.

Cheers,
Matt
-- =

Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
--===============1432304300387125961==--
