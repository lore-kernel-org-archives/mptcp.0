Content-Type: multipart/mixed; boundary="===============3380631431071546311=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH v3 7/9] mptcp: add netlink based PM
Date: Wed, 26 Feb 2020 10:46:03 +0100
Message-ID: <f9a33bca90c3c5f2ea6af11427f512d30ea31f6f.camel@redhat.com>
In-Reply-To: 20200226093647.GN19559@breakpoint.cc
X-Status: 
X-Keywords:                  
X-UID: 3806

--===============3380631431071546311==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Wed, 2020-02-26 at 10:36 +0100, Florian Westphal wrote:
> Paolo Abeni <pabeni(a)redhat.com> wrote:
> > I see! Yes, currently we can't limit the number of subflows created for
> > a single mptcp socket on a server. I'm unsure how bad that is, as
> > usually we allow each client to create an arbitrary high number of TCP
> > connection to the server (modulo syn flood).
> > =

> > Still I think adding the ability to impose such limit could be nice. It
> > requires an additional hook (from subflow_syn_recv_sock() towards the
> > PM). If we agree on that, I can try to cover in a separate
> > patch/series.
> =

> I think its a must-have, as file descriptor limits don't apply.

Ok I'll work on that! =


Can we still merge the series without this feature to unblock Peter ?

Thanks,

Paolo

--===============3380631431071546311==--
