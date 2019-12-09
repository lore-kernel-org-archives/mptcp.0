Content-Type: multipart/mixed; boundary="===============2244926626370640807=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH 0/1] proposed export branch rebase
Date: Mon, 09 Dec 2019 13:33:51 +0100
Message-ID: <231a2fa522f7713fc8d8b0a5069153b2a40a1293.camel@redhat.com>
In-Reply-To: 20191208182417.16789-1-fw@strlen.de
X-Status: 
X-Keywords:                  
X-UID: 2847

--===============2244926626370640807==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi,

On Sun, 2019-12-08 at 19:24 +0100, Florian Westphal wrote:
> It includes 48 patches (down from 66), I will refrain from patch-bombing
> the list with it.  There is one patch as followup here because its
> "almost new" in the sense that its an amalgamation of different patches
> that I placed in that commit because the others seemed quite large alread=
y.
> =

> The __tcp_poll patch is gone.  Later patches, in particular the changes to
> only store 'tcp_sock' rather than 'struct socket' on the conn_list, have
> been brought forward and squashed into the relevant commits, would thus
> be implicitly part of basic mptcp submission.  I've amemded commit
> messages where appropriate.

Thank you Florian for the great work!

I went through the patches up to v1 support, and LGTM.

> There are more opportunities for squashing after the kselftest commit,
> but I did not do this.  Unless there is a need to do so I would prefer
> to add smaller patches after basic functionality is working.

Agreed!

I'll try to rebase and squash the fallback cleanup patches on top of
this.

Thanks,

Paolo

--===============2244926626370640807==--
