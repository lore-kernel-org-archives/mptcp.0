Content-Type: multipart/mixed; boundary="===============4981498261133414353=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH] linux: handle MPTCP consistently with TCP
Date: Wed, 16 Dec 2020 18:22:11 +0100
Message-ID: <02d190afcb6e32f4aa3d1d228f762ab620f3c406.camel@redhat.com>
In-Reply-To: 27d6afd1-9a2e-e258-dd09-e943de06f480@schaufler-ca.com
X-Status: 
X-Keywords:                  
X-UID: 7195

--===============4981498261133414353==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hello,

On Wed, 2020-12-16 at 08:31 -0800, Casey Schaufler wrote:
> On 12/16/2020 3:55 AM, Paolo Abeni wrote:
> > The MPTCP protocol uses a specific protocol value, even if
> > it's an extension to TCP. Additionally, MPTCP sockets
> > could 'fall-back' to TCP at run-time, depending on peer MPTCP
> > support and available resources.
> > =

> > As a consequence of the specific protocol number, selinux
> > applies the raw_socket class to MPTCP sockets.
> =

> Have you looked at the implications for Smack?

AFAICS, the only hooks which can be affected is
smack_socket_post_create() - that is, the only hook with a 'protocol'
argument coming directly from the socket APIs.

If I read the code correctly, such hook behaves independently from
'protocol' value. Overall no changes should be needed for smack.

Thanks!

Paolo

--===============4981498261133414353==--
