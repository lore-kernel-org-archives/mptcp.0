Content-Type: multipart/mixed; boundary="===============6425279168382912684=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [RFC PATCH 2/4] Squash-to "mptcp: Create SUBFLOW socket
 for incoming connection"
Date: Fri, 03 Jan 2020 11:33:06 +0100
Message-ID: <b49fb77f8f4ee173bc7362965927d37d8a3a5d85.camel@redhat.com>
In-Reply-To: alpine.OSX.2.21.1912201411080.52347@mkavai-mobl.amr.corp.intel.com
X-Status: 
X-Keywords:                  
X-UID: 3254

--===============6425279168382912684==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Fri, 2019-12-20 at 14:12 -0800, Mat Martineau wrote:
> On Fri, 20 Dec 2019, Paolo Abeni wrote:
> =

> > use is_mptcp instead of 'subflow->mp_capable'
> =

> There is still some similar use of subflow->mp_capable in other places =

> (subflow.c, options.c) - should those also be re-examined for possible =

> change to is_mptcp?

After a not-so-quick check I think there are only 2 additional places
where the above applies - e.g. we really check for TCP fallback:

* in subflow.c, subflow_data_ready()

* in options.c, mptcp_established_options()

AFAICS all other places we really check mp_capable (vs mp_join)

I'll cover the above in the (upconing) next iteration.

Thanks,

Paolo




--===============6425279168382912684==--
