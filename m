Content-Type: multipart/mixed; boundary="===============0228453796671514900=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH v2 0/7] fallback to TCP on ulp clone failure
Date: Thu, 16 Jan 2020 16:18:14 +0100
Message-ID: <c2929ebd02d068b6b20a76cd2fae7d600950130a.camel@redhat.com>
In-Reply-To: e01e4069-25de-b5a1-4a98-4b8003f30b87@tessares.net
X-Status: 
X-Keywords:                  
X-UID: 3374

--===============0228453796671514900==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Wed, 2020-01-15 at 23:23 +0100, Matthieu Baerts wrote:
> On 15/01/2020 23:01, Matthieu Baerts wrote:
> > Hi Paolo, Mat,
> > =

> > On 09/01/2020 23:27, Mat Martineau wrote:
> > > On Thu, 9 Jan 2020, Paolo Abeni wrote:
> > > =

> > > > This series do real TCP fallback for passive MPTCP connection when =

> > > > ULP clone
> > > > fails: clear the 'is_mptcp' flag, reset overridden callback, icsk o=
ps =

> > > > and
> > > > clear the ULP ctx.
> > > > =

> > > > Additionally uses the 'is_mptcp' flag to check for fallback in more =

> > > > places,
> > > > as suggested by Mat (patches 2, 4), cope with NULL ctx in
> > > > subflow_syn_recv_sock() (patches 3, 7), and restore TCP callback on
> > > > later fallback, too (patch 6) for consistency.
> > > > =

> > > > This still uses function pointers to store all the overriden TCP =

> > > > callbacks,
> > > > is simpler then other alternatives but waste some space inside the =

> > > > subflow
> > > > struct.
> > > > =

> > > > The rebased tree is available at:
> > > > =

> > > > https://github.com/pabeni/mptcp/tree/mptcp_net-next_export_v7.1
> > > > =

> > > > This is on top of export branch(a)b50a38e09bbc6182136836564945a3236=
41a5039
> > > > (tag: export/20200109T154238)
> > > > =

> > > > v1 -> v2
> > > > - uses sk_is_mptcp() when possible (Mat)
> > > > - drop rendundant checks (Mat)
> > > > =

> > > > options.c  |    7 ------
> > > > protocol.c |   20 ++++++++---------
> > > > protocol.h |   15 ++++++++++++-
> > > > subflow.c  |   68 =

> > > > ++++++++++++++++++++++++++++++++++++++++---------------------
> > > > 4 files changed, 68 insertions(+), 42 deletions(-)
> > > =

> > > Hi Paolo -
> > > =

> > > Thanks for the fixes from v1. Looks good to me.
> > =

> > Thank you for the patches and the reviews!
> > =

> > Please check the "/!\" below
> > =

> > - e0350744cafc: "squashed" patch 1/7 in "mptcp: Handle MP_CAPABLE =

> > options for outgoing connections"
> > - 65850c198790: conflict in t/mptcp-Add-key-generation-and-token-tree
> > - 7a3cef638c7b: conflict in t/mptcp-Implement-MPTCP-receive-path
> > - fba261bbcdd9: conflict in t/mptcp-process-MP_CAPABLE-data-option
> >    /!\ comment is re-added below
> > - af9296ffbeec: conflict in t/mptcp-cope-with-later-TCP-fallback
> > - 55dbb555ec6c: conflict in =

> > t/mptcp-Add-handling-of-incoming-MP_JOIN-requests
> >    /!\ I had to modify the first condition in subflow_ulp_clone()
> > - 7e25825cceea: mptcp:subflow: re-add removed comment in =

> > t/mptcp-process-MP_CAPABLE-data-option
> > - 5593f3432c76] Revert "mptcp:subflow: re-add removed comment" in =

> > t/mptcp-Add-handling-of-incoming-MP_JOIN-
> > - 5c6690820e0a..513c7bff2864: result
> > =

> > - df2d5cfd1573: "squashed" patch 2/7 in "mptcp: Create SUBFLOW socket =

> > for incoming connections"
> > - b146e9ab6e2a: conflict in =

> > t/mptcp-recvmsg-can-drain-data-from-multiple-subflows
> > - 6bc74228e82e: conflict in t/mptcp-increment-MIB-counters-in-a-few-pla=
ces
> > - 513c7bff2864..dbf315c33403: result
> > =

> > - 3abec1c771df: "squashed" patch 3/7 in "mptcp: Add key generation and =

> > token tree"
> > - dbf315c33403..72aec0bc2ad9: result
> > =

> > - ecde144ffa56: "squashed" patch 4/7 in "mptcp: Write MPTCP DSS headers =

> > to outgoing data packets"
> > - 006e52131d4f: conflict in =

> > t/mptcp-parse-and-emit-MP_CAPABLE-option-according-to-v1-spec
> > - b0ae53ced8cd: conflict in t/mptcp-Add-ADD_ADDR-handling
> > - d099fdd0460f: conflict in =

> > t/mptcp-Add-handling-of-outgoing-MP_JOIN-requests
> > - 72aec0bc2ad9..1f5cf153a4b1: result
> > =

> > - 73afeb8aabbd: "squashed" patch 5/7 in "mptcp: Implement MPTCP receive =

> > path"
> > - 6259583be5a2: conflict in t/mptcp-Add-path-manager-interface
> > - 23f44e1993f4: conflict in =

> > t/mptcp-Add-handling-of-incoming-MP_JOIN-requests
> >    /!\ tcp_state_change and tcp_write_space have been set for both like =

> > in mptcp_net-next_export_v6.2
> > - 49007086b792: conflict in =

> > t/mptcp-Add-handling-of-outgoing-MP_JOIN-requests
> > - 1f5cf153a4b1..803fb6ea75b0: result
> > =

> > - 5724921dc089: "squashed" patch 6/7 in "mptcp: cope with later TCP =

> > fallback"
> >    /!\ the second part of the patch was already applied in a previous =

> > conflict resolution
> > - 803fb6ea75b0..02e14c69386b: result
> > =

> > - aa031bb3cab2: "squashed" patch 7/7 in "mptcp: Add handling of incomin=
g =

> > MP_JOIN requests"
> > - 6d39473b63da: "Signed-off-by" + "Co-developed-by"
> > - 02e14c69386b..f15fa3697153: result
> > =

> > Compilation is OK but tests are in progress.
> =

> A small additional fix to allow the compilation of each exported commit:
> =

> - 843c30e1447a: mptcp: fix compilation error in =

> t/mptcp-parse-and-emit-MP_CAPABLE-option-according-to-v1-spec
> - d27c2802c206: mptcp: fix compilation error in =

> t/mptcp-process-MP_CAPABLE-data-option
> - ed5fd3d9a3e8: conflict in t/mptcp-Add-path-manager-interface
> - f15fa3697153..a8dcfeb3a5c6: result (empty, normal)

Thank you for all the great work!

I checked the mentioned relevant conflict commits, the delta vs my
local tree and did some self-tests run. LGTM

Thanks,

Paolo

--===============0228453796671514900==--
