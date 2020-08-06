Content-Type: multipart/mixed; boundary="===============1577658755235218183=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH 00/13] mptcp: multiple xmit substreams support
Date: Thu, 06 Aug 2020 20:39:25 +0200
Message-ID: <2297c590-8ee2-af2f-67d8-d41e24ddd187@tessares.net>
In-Reply-To: cover.1596649926.git.pabeni@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 5503

--===============1577658755235218183==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Paolo, Florian,

On 05/08/2020 19:56, Paolo Abeni wrote:
> This covers the feedback from Florian on the RFC series, please see
> the individual patches changelog for the details.
> =

> The only exception is: I'm retaining the MPTCP_SEND_SPACE bit, which looks
> required as per ML discussion.
> =

> The MPTCP window code is now more conservative and I do not see out of wi=
ndow
> errors.
> =

> Some self-tests cases are still failing - do not reach the expected aggre=
gated
> bwidth - but I've not investigated yet. multiple stream self-tests are not
> enabled yet.
> =

> It would be great if we could starting merging this in the export branch,
> and improve incrementally.

Thank you for the patches and the reviews!

I just added these 13 patches at the end of the export branches.

Tests are in progress! I will inform you about the status later once it =

is done.

Note that I fixed a few small checkpatch issues, nothing important:


=3D=3D=3D=3D=3D=3D=3D 8< =3D=3D=3D=3D=3D=3D=3D=3D
+ ./.checkpatch.sh '[PATCH 02_13] mptcp: set data_ready status bit in =

subflow_check_data_avail()'
ERROR: Missing Signed-off-by: line(s)


+ ./.checkpatch.sh '[PATCH 06_13] mptcp: move ooo skbs into msk out of =

order queue.'
WARNING: 'enqueing' may be misspelled - perhaps 'enqueuing'?
#109:
After successfully enqueing in sequence data, check

ERROR: "(foo*)" should be "(foo *)"
#177: FILE: net/mptcp/protocol.c:146:
+       return mptcp_try_coalesce((struct sock*)msk, to, from);

ERROR: spaces required around that ':' (ctx:VxW)
#194: FILE: net/mptcp/protocol.c:163:
+       max_seq =3D max_seq > 0 ? max_seq + msk->ack_seq: msk->ack_seq;
                                                       ^

+ ./.checkpatch.sh '[PATCH 09_13] mptcp: move address attribute into =

mptcp_addr_info'
WARNING: Missing a blank line after declarations
#202: FILE: net/mptcp/pm_netlink.c:463:
+               u32 val =3D nla_get_s32(tb[MPTCP_PM_ADDR_ATTR_IF_IDX]);
+               entry->addr.ifindex =3D val;

+ ./.checkpatch.sh '[PATCH 11_13] mptcp: allow picking different xmit =

subflows'
WARNING: 'exausted' may be misspelled - perhaps 'exhausted'?
#104:
space is exausted, move to the next one with available

CHECK: Prefer using the BIT macro
#143: FILE: net/mptcp/protocol.c:1044:
+#define MPTCP_SEND_BURST_SIZE          (1 << 15)

ERROR: spaces required around that ':' (ctx:VxW)
#176: FILE: net/mptcp/protocol.c:1072:
+               *sndbuf =3D msk->first ? msk->first->sk_sndbuf: 0;
                                                             ^

+ ./.checkpatch.sh '[PATCH 12_13] mptcp: simult flow self-tests'
WARNING: adding a line without newline at end of file
#407: FILE: tools/testing/selftests/net/mptcp/simult_flows.sh:290:
+exit $ret
=3D=3D=3D=3D=3D=3D=3D 8< =3D=3D=3D=3D=3D=3D=3D=3D

There are two remaining ones:
- one see patch 3/13 and 7/13 (unsigned)
- one for patch 1/13: memory barrier without comment =

(smp_mb__after_atomic())

Nothing to worry I guess.

Cheers,
Matt
-- =

Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
--===============1577658755235218183==--
