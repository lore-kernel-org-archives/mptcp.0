Content-Type: multipart/mixed; boundary="===============9113971942577319768=="
MIME-Version: 1.0
From: Davide Caratti <dcaratti at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH net] mptcp: fix NULL ptr dereference on bad MPJ
Date: Thu, 26 Nov 2020 12:42:46 +0100
Message-ID: <c0cb62594231f5b38fc4c4a92a34d035a5c40356.camel@redhat.com>
In-Reply-To: 7245da72fb7b1936b2c872c8a8c465012763ed17.1606385694.git.pabeni@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 6950

--===============9113971942577319768==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Thu, 2020-11-26 at 11:15 +0100, Paolo Abeni wrote:
> If an msk listener receives an MPJ carrying an invalid token, it
> will zero the request socket msk entry. That should later
> cause fallback and subflow reset - as per RFC - at
> subflow_syn_recv_sock() time due to failing hmac validation.
> =

> Since commit 4cf8b7e48a09 ("subflow: introduce and use
> mptcp_can_accept_new_subflow()"), we unconditionally dereference
> - in mptcp_can_accept_new_subflow - the subflow request msk
> before performing hmac validation. In the above scenario we
> hit a NULL ptr dereference.
> =

> Address the issue doing the hmac validation earlier.
> =

> Fixes: 4cf8b7e48a09 ("subflow: introduce and use mptcp_can_accept_new_sub=
flow()")
> Signed-off-by: Paolo Abeni <pabeni(a)redhat.com>

kernel does not crash anymore. It still sends a 0 HMAC, and resets the
connection after the 3WHS - see https://paste.centos.org/view/d962741c
(not sure if it's RFC compliant, but for sure it fixes the issue :) )

Tested-by: Davide Caratti <dcaratti(a)redhat.com>


--===============9113971942577319768==--
