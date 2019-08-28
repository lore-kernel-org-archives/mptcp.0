Content-Type: multipart/mixed; boundary="===============4168657346710417702=="
MIME-Version: 1.0
From: Florian Westphal <fw at strlen.de>
To: mptcp at lists.01.org
Subject: [MPTCP] Fwd: multipath tcp MIB counter placement - share with tcp or
 extra?
Date: Wed, 28 Aug 2019 13:46:11 +0200
Message-ID: <20190828114611.GH20113@breakpoint.cc>
X-Status: 
X-Keywords:                  
X-UID: 1735

--===============4168657346710417702==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Just FYI, I've asked Eric Dumazet on how/where to add MIB stats for
MPTCP.

I don't think its high-prio to have them right now but I think its
important to add MPTCP stats at some point.

Cheers,
Florian

----- Forwarded message from Florian Westphal <fw(a)strlen.de> -----

Hi Eric,

The out-of-tree multipath TCP stack adds a few MIB counters to track
(and debug) MTPCP behaviour.  Examples:

        SNMP_MIB_ITEM("MPCapableSYNRX", MPTCP_MIB_MPCAPABLEPASSIVE),
        SNMP_MIB_ITEM("MPCapableSYNTX", MPTCP_MIB_MPCAPABLEACTIVE),
[..]
        SNMP_MIB_ITEM("MPTCPRetrans", MPTCP_MIB_RETRANSSEGS),
        SNMP_MIB_ITEM("MPFailRX", MPTCP_MIB_MPFAILRX),
        SNMP_MIB_ITEM("MPCsumFail", MPTCP_MIB_CSUMFAIL),

and so on.

I think that such MIB counters would be good to have in the 'upstreaming'
attempt as well.

The out-of-tree code keeps them separate from the tcp mib counters and also
exposes them in a different /proc file (/proc/net/mptcp_net/snmp).

Would you be ok with mptcp-upstreaming adding its MIB counters to the
existing TCP MIB instead?

This would make 'nstat' and other tools pick them up automatically.
It would also help TCP highlevel debugging to see if MPTCP is involved
in any way.

Let me know -- I can go with a separate MIB, its no problem, I just want
to avoid going down the wrong path.

Thanks,
Florian

----- End forwarded message -----

--===============4168657346710417702==--
