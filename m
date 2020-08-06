Content-Type: multipart/mixed; boundary="===============7520970979604814317=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] mptcp diag interface weirdness
Date: Thu, 06 Aug 2020 12:41:43 +0200
Message-ID: <d721c9c89256ae6c5dc7c3a268f1e2165a8edf7c.camel@redhat.com>
X-Status: 
X-Keywords:                  
X-UID: 5497

--===============7520970979604814317==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

hi all,

while looking at:

https://github.com/multipath-tcp/mptcp_net-next/issues/68

I noticed we have some very unnice behavior with kernel
without 3f935c75eb52dd968351dba824adf466fb9c9429, specifically:

ss fills 'sdiag_protocol' with MPTCP_PROTOCOL; since 'sdiag_protocol'
is 1 byte long, it will become 'TCP_PROTOCOL'. Then adds
 INET_DIAG_REQ_PROTOCOL really containing 'MPTCP_PROTOCOL'.

Since the older kernel does not know 'INET_DIAG_REQ_PROTOCOL', it will
ignore it and will call the tcp diag, which in turn will look into the
TCP table. Even the filter will usually match, as we will likely have a
TCP subflow matching the MPTCP socket 4 tuple.

In the end 'ss' will get back a TCP diag info, but will interpret it as
an MPTCP one, dumping quite weird values.

The only solution I can think is changing 'ss' to
override 'sdiag_protocol' with 255 when setting INET_DIAG_REQ_PROTOCOL.

255 is reserver from IANA, so no diag handler is expected, and the
kernel should report (correctly) a protocol unknown error.

WDYT?

Thanks,

Paolo

p.s. all the above will not fix (yet) issues/68

--===============7520970979604814317==--
