Content-Type: multipart/mixed; boundary="===============4585007548046578156=="
MIME-Version: 1.0
From: Florian Westphal <fw at strlen.de>
To: mptcp at lists.01.org
Subject: [MPTCP] scheduling-while-atomic splat in mptcp_shutdown
Date: Fri, 26 Apr 2019 16:27:46 +0200
Message-ID: <20190426142746.3h6xgt5x54rg6kfy@breakpoint.cc>
X-Status: 
X-Keywords:                  
X-UID: 1091

--===============4585007548046578156==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi,

I get following splat in mptcp_shutdown:
-----
BUG: sleeping function called from invalid context at net/core/sock.c:2911
in_atomic(): 0, irqs_disabled(): 0, pid: 2238, name: mptcp_connect
[   61.599662] 1 lock held by mptcp_connect/2238:
[   61.600395]  #0: 000000005d0e085e (rcu_read_lock){....}, at: mptcp_shutd=
own+0x91/0x2a0
[   61.601754] Preemption disabled at:
[   61.601780] [<ffffffff811a28ee>] rcu_lockdep_current_cpu_online+0x2e/0xa0
[   61.606184] Call Trace:
[   61.607183]  ? rcu_lockdep_current_cpu_online+0x2e/0xa
[   61.608047]  ___might_sleep.cold.73+0x129/0x13d
[   61.608800]  lock_sock_nested+0x32/0xc0
[   61.609447]  inet_shutdown+0x51/0x1c0
[   61.609999]  mptcp_shutdown+0x13e/0x2a0
-----

I can look into it next week in case noone more familiar with
the code has time to work on this.

--===============4585007548046578156==--
