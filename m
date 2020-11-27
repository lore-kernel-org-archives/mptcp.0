Content-Type: multipart/mixed; boundary="===============7836888623500920977=="
MIME-Version: 1.0
From: Jakub Kicinski <kuba at kernel.org>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH net] mptcp: fix NULL ptr dereference on bad MPJ
Date: Fri, 27 Nov 2020 11:06:49 -0800
Message-ID: <20201127110649.62563a6c@kicinski-fedora-pc1c0hjn.DHCP.thefacebook.com>
In-Reply-To: 2c3eecf9-c3b9-861a-cb8c-2f103496abfc@tessares.net
X-Status: 
X-Keywords:                  
X-UID: 6968

--===============7836888623500920977==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Thu, 26 Nov 2020 16:23:08 +0100 Matthieu Baerts wrote:
> On 26/11/2020 15:17, Paolo Abeni wrote:
> > If an msk listener receives an MPJ carrying an invalid token, it
> > will zero the request socket msk entry. That should later
> > cause fallback and subflow reset - as per RFC - at
> > subflow_syn_recv_sock() time due to failing hmac validation.
> > =

> > Since commit 4cf8b7e48a09 ("subflow: introduce and use
> > mptcp_can_accept_new_subflow()"), we unconditionally dereference
> > - in mptcp_can_accept_new_subflow - the subflow request msk
> > before performing hmac validation. In the above scenario we
> > hit a NULL ptr dereference.
> > =

> > Address the issue doing the hmac validation earlier.
> > =

> > Fixes: 4cf8b7e48a09 ("subflow: introduce and use mptcp_can_accept_new_s=
ubflow()")
> > Tested-by: Davide Caratti <dcaratti(a)redhat.com>
> > Signed-off-by: Paolo Abeni <pabeni(a)redhat.com>  =

> =

> Good catch! Thank you for the patch!
> =

> Reviewed-by: Matthieu Baerts <matthieu.baerts(a)tessares.net>

Applied, thanks!
--===============7836888623500920977==--
