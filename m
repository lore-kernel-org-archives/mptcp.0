Content-Type: multipart/mixed; boundary="===============2675389599670190718=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: Stable backport for DATA_FIN fix?
Date: Wed, 10 Mar 2021 11:02:07 +0100
Message-ID: <3275c3586559beb4dea23af7345d96d12a9e00b4.camel@redhat.com>
In-Reply-To: cec5e9c-b83-3880-f73a-5ba74b9d9844@linux.intel.com
X-Status: 
X-Keywords:                  
X-UID: 8087

--===============2675389599670190718==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Tue, 2021-03-09 at 17:59 -0800, Mat Martineau wrote:
> Greg KH hit a conflict when applying "mptcp: fix DATA_FIN generation on =

> early shutdown" to 5.10-stable.
> =

> (upstream commit for reference: =

> https://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git/commit/?id=
=3Dd87903b63e3ce1eafaa701aec5cc1d0ecd0d84dc =

> )
> =

> The conflict is fairly simple to resolve, do you think that one is worth =

> the effort for v5.10.x? I can handle the backport.

No objection on my side ;) but also no available CPU cycles here :( So
if you can go ahead, I would appreciate that!

Thanks!

Paolo

--===============2675389599670190718==--
