Content-Type: multipart/mixed; boundary="===============6807797122295376027=="
MIME-Version: 1.0
From: Peter Krystad <peter.krystad at linux.intel.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH 1/6] mptcp: Reference af_ops routines through
 struct ipv4_specific
Date: Tue, 05 Nov 2019 14:29:05 -0800
Message-ID: <0bb8bde41198b0c5ead5bfba5b031917ba1408dd.camel@linux.intel.com>
In-Reply-To: ff27752250167ac9a3b609ad604c4b565c38bc3a.camel@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 2408

--===============6807797122295376027==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Thu, 2019-10-31 at 09:33 +0100, Paolo Abeni wrote:
> On Wed, 2019-10-30 at 16:38 -0700, Peter Krystad wrote:
> > Make this look similar to how it will have to be done for IPv6,
> > as the IPv6 routines are declared static and thus not visible.
> > =

> > Signed-off-by: Peter Krystad <peter.krystad(a)linux.intel.com>
> =

> I think:
> =

> - 'subflow_finish_connect()' and 'inet_connection_sock_af_ops
> subflow_specific;' changes should be squashed into "mptcp: Handle
> MP_CAPABLE options for outgoing connections"
> =

> - 'subflow_syn_recv_sock()' into "mptcp: Create SUBFLOW socket for
> incoming connections"
> =

> - 'inet_sk_rebuild_head()' into "mptcp: Add key generation and token
> tree"
> =

> right?
> =

> /P
> =


In the v2 patchset I am going to modify this change. We will save a pointer
to the original af_icsk_ops structure and call the inet_xxx routines through
it. This will save a lot of code duplication for IPv6.

The change will squash to the same commits you identify above.

Peter.=20

--===============6807797122295376027==--
