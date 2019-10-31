Content-Type: multipart/mixed; boundary="===============1576794317589672474=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH 0/6] IPv6 support
Date: Thu, 31 Oct 2019 10:02:42 +0100
Message-ID: <89ee912f38069b1a757de76b71fcf5f8a8eb6caa.camel@redhat.com>
In-Reply-To: 20191030233844.4790-1-peter.krystad@linux.intel.com
X-Status: 
X-Keywords:                  
X-UID: 2373

--===============1576794317589672474==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Wed, 2019-10-30 at 16:38 -0700, Peter Krystad wrote:
> Implemented support for IPv6. selftests pass with ipv6=3Dtrue, =


Nice! =


> but they take twice as long to run...

Yep, that is expected, right? ;)

> With re-factoring the addition of IPv6 is very clean but I did not
> split files yet as it will be hard to squash any changes after the
> such a split.

We still need the Kconfig boilerplate, right? something alike:

---
diff --git a/net/mptcp/Kconfig b/net/mptcp/Kconfig
index f21190a4f7e9..3fa6d91f57ee 100644
--- a/net/mptcp/Kconfig
+++ b/net/mptcp/Kconfig
@@ -9,3 +9,8 @@ config MPTCP
          uses the TCP protocol, and TCP options carry header
information for
          MPTCP.
 =

+config MPTCP_IPV6
+       bool "IPv6 support form Multipath TCP"
+       depends on MPTCP
+       select IPV6
+       default y
---

and than replace IS_ENABLED(IPV6) with CONFIG_MPTCP_IPV6.

Additinal question: what happens if ipv6 is disabled at boot time
(ipv6.disable=3D1 on the kernel command line)?

Thanks,

Paolo

--===============1576794317589672474==--
