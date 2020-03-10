Content-Type: multipart/mixed; boundary="===============2546454641798577695=="
MIME-Version: 1.0
From: Mat Martineau <mathew.j.martineau at linux.intel.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH net-next 0/2] mptcp: simplify mptcp_accept()
Date: Mon, 09 Mar 2020 17:57:03 -0700
Message-ID: <alpine.OSX.2.22.394.2003091734550.11245@brhill-mobl.amr.corp.intel.com>
In-Reply-To: cover.1583511159.git.pabeni@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 3896

--===============2546454641798577695==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable


On Fri, 6 Mar 2020, Paolo Abeni wrote:

> this is a rebase on top of net-next, with hopefully
> more correct error handling - catches mptcp_token_new_accept()
> errors and fallback to TCP freeing the newly create msk.
>
> Additionally add a follow-up patch dropping unneeded
> subflow->conn checks.
>
> Idea is to send this upstream after that -net is merged back
> into -net-next, to deal with conflicts in
> mptcp_established_options_dss() due to 2398e3991bda ("mptcp:
> always include dack if possible.")
>

I think there should be a merge from -net soon, as there's a conflict in =

inet_diag.c that will likely trip up the linux-next merge.

The changes look good. With the cleanup in the second patch, there's one =

additional area that I have a question about that wasn't modified. At the =

end of mptcp_subflow_create_socket(), subflow->conn is assigned after the =

subflow sock lock is released. Since the socket and context are newly =

created it may be safe to modify subflow->conn without the lock, but it =

would be simple to rearrange slightly and complete the subflow setup with =

the lock held (the lock is acquired for a reason, right?).

--
Mat Martineau
Intel
--===============2546454641798577695==--
