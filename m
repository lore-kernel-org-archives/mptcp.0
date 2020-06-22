Content-Type: multipart/mixed; boundary="===============3431460921582027958=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: sock diag uAPI and MPTCP
Date: Mon, 22 Jun 2020 12:18:52 +0200
Message-ID: <07e0f81138421beee347c362dce61f78dd8bf00c.camel@redhat.com>
In-Reply-To: 20200620.174408.1728600398443363480.davem@davemloft.net
X-Status: 
X-Keywords:                  
X-UID: 4761

--===============3431460921582027958==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Sat, 2020-06-20 at 17:44 -0700, David Miller wrote:
> From: Paolo Abeni <pabeni(a)redhat.com>
> Date: Fri, 19 Jun 2020 12:54:40 +0200
> =

> > IPPROTO_MPTCP value (0x106) can't be represented using the current sock
> > diag uAPI, as the 'sdiag_protocol' field is 8 bits wide.
> > =

> > To implement diag support for MPTCP socket, we will likely need a
> > 'inet_diag_req_v3' with a wider 'sdiag_protocol'
> > field. inet_diag_handler_cmd() could detect the version of
> > the inet_diag_req_v* provided by user-space checking nlmsg_len() and
> > convert _v2 reqs to _v3.
> > =

> > This change will be a bit invasive, as all in kernel diag users will
> > then operate only on 'inet_diag_req_v3' (many functions' signature
> > change required), but the code-related changes will be encapsulated
> > by inet_diag_handler_cmd().
> =

> Another way to extend the size of a field is to add an attribute which
> supercedes the header structure field when present.
> =

> We did this when we needed to make the fib rule table ID number larger,
> see FRA_TABLE.
> =

> You'd only need to specify this when using protocol values larger than
> 8 bits in size.

Thank you very much for the directions! This looks like a better, more
encapsulated solution. I'll try to give it a shot.

Thanks!

Paolo

--===============3431460921582027958==--
