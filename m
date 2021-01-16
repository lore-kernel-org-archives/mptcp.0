Content-Type: multipart/mixed; boundary="===============2058643623330367287=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH mptcp-next] Squash to "mptcp: drop *_max fields in
 mptcp_pm_data"
Date: Sat, 16 Jan 2021 12:49:10 +0100
Message-ID: <efaecd93-680c-77f0-7b0b-65a15ec35c73@tessares.net>
In-Reply-To: 20210116113653.3918024-1-matthieu.baerts@tessares.net
X-Status: 
X-Keywords:                  
X-UID: 7410

--===============2058643623330367287==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi

On 16/01/2021 12:36, Matthieu Baerts wrote:
> We need to export these functions that are also used in mptcp_diag.c
> which can be part of a separated module.
> =

> We can then avoid these errors:
> =

>    ERROR: modpost: "mptcp_pm_get_add_addr_accept_max" [net/mptcp/mptcp_di=
ag.ko] undefined!
>    ERROR: modpost: "mptcp_pm_get_add_addr_signal_max" [net/mptcp/mptcp_di=
ag.ko] undefined!
>    ERROR: modpost: "mptcp_pm_get_subflows_max" [net/mptcp/mptcp_diag.ko] =
undefined!

This is now applied in our git repo.

Cheers,
Matt
-- =

Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
--===============2058643623330367287==--
