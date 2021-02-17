Content-Type: multipart/mixed; boundary="===============6471172950297459195=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] insonsistend subflow creation policy ?!?
Date: Wed, 17 Feb 2021 17:42:16 +0100
Message-ID: <1f2bbfaba037c836d7c718eb6ac1aa8266ec83a0.camel@redhat.com>
X-Status: 
X-Keywords:                  
X-UID: 7823

--===============6471172950297459195==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hello,

I just noted that the pm_netlink subflow creation policy is
inconsistent (or perhaps simply different ?!?) between signal and
add_addr subflows.

When the MPTCP socket tries to create additional subflow due an
'subflow' endpoint, it will filter out local addresses already in use
by existing subflow.

When MPTCP tries to create an additional subflow due to an incoming
'ADD_ADDR' option, it will try to create it regardless any existing
subflow using the relevant remote address (and port).

Should we change the above ?!? (e.g. applying some filters even for
ADD_ADDR). Or perhpas add some additional policy flag (like 'unique' or
'none') ?

WDYT?

Thanks!

Paolo

--===============6471172950297459195==--
