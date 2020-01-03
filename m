Content-Type: multipart/mixed; boundary="===============1626689458259108666=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [RFC PATCH 3/4] Squash-to: "mptcp: Implement MPTCP
 receive path"
Date: Fri, 03 Jan 2020 11:00:02 +0100
Message-ID: <df8008e87bcf414e97fccbc4d4d2c0c866acaf1a.camel@redhat.com>
In-Reply-To: alpine.OSX.2.21.1912201350170.52347@mkavai-mobl.amr.corp.intel.com
X-Status: 
X-Keywords:                  
X-UID: 3252

--===============1626689458259108666==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Fri, 2019-12-20 at 14:06 -0800, Mat Martineau wrote:
> On Fri, 20 Dec 2019, Paolo Abeni wrote:
> =

> > deal with fallback: we must reset sk callback to the TCP one.
> > Use the cached ptr in the old ctx.
> =

> Hi Paolo -
> =

> Is this required if subflow_data_ready(), subflow_state_change(), and =

> subflow_write_space() only call through to the normal TCP functions when =

> ctx->conn is NULL? =


Uhm... almost. The actuall condition is somewhat more complex, but we
can indeed replace the indirect call with condition + direct call,
except that 'sock_def_wakeup()' - tcp -> sk_state_change - is declared
as static in net/core/sock.c. =


We can't direct-call that function and the current mptcp code duplicate
it - which is not so nice BTW.

Quick greeping inside the '/net' subtree shows that the preferred
solution when overriding sock callback is storing the old one and use
indirect calls.

I guess that is due to pre-spectre implementations and to avoid
inferring internals of the overridden sock status.

Likely MPTCP already assumes TCP specific semantic for the underlying
sock in several places, so we could possibly avoid the indirect calls,
but we would need to make visible 'sock_def_wakeup()'. Do we need an
additional pre-req patch for that?

In this RFC I vilely and intentionally opted for the quickest/dumbest
solution to avoid the above tricky questions ;)
 =

Perhpas we should really opt for the direct-call solution - exporting
sock_def_wakeup() in "mptcp: Implement MPTCP receive path"???

Any suggestions more than welcome!

Cheers,

Paolo

--===============1626689458259108666==--
