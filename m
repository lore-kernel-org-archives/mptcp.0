Content-Type: multipart/mixed; boundary="===============0786554918179851578=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH] mptcp: Use sk_family field in the mptcp_sock for
 address family.
Date: Tue, 05 Nov 2019 09:20:21 +0100
Message-ID: <56f99f8699f42ae8f0cb61e30db157cd12c2eb06.camel@redhat.com>
In-Reply-To: 20191105052624.3269-1-peter.krystad@linux.intel.com
X-Status: 
X-Keywords:                  
X-UID: 2389

--===============0786554918179851578==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Mon, 2019-11-04 at 21:26 -0800, Peter Krystad wrote:
> It was not necessary to add a family field to mptcp_sock as it is
> a wrapper around a struct sock, and sk_family is set correctly when
> the msk is created as a result of a socket() call.
> =

> squashto: Associate MPTCP context with TCP socket
>           mptcp: Implement basic path manager
> =

> Signed-off-by: Peter Krystad <peter.krystad(a)linux.intel.com>

LGTM, nice cleanup, thanks!

It's unclear to me if I should update patchwork status, too ("Under
review"? would that help?)

Paolo

--===============0786554918179851578==--
