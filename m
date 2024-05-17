Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CB9F1598E3
	for <mptcp@lists.linux.dev>; Fri, 17 May 2024 17:41:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715967673; cv=none; b=BQNdN+JjdkbPFmpG+iwn3rpjkrnqdoXDsC7abrOskI8lDRMDd2RzvgUQtYH9aqz4Ihc3csSw666KwH7nb6Mo5r7p6ofbH+f6lIDhgwjD96ckJlD4UGtEFWGF1xQahoA/PYYa0YMCYgu4qGcd+ZxO9t6vTnqtDb8lsdgC7PeXKtQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715967673; c=relaxed/simple;
	bh=LOhCoGeoA8WzbPnd3geK65B/Qz0jnknXrCon4X8++uI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=bTXDpQ5OIYNRh3XxWpopVK6immR/3vh+QqVQiTJlTLfBWWpLrSEtuJ/xIodhwweDrKQJKGQfCZHX/knaArFcBZGb6MdNK2JkFtswFEVZvqGfl+HIv34YxUIAKmtVJtLl+I8k+vff33HOZgwo8Khkf/oHQXPvkVpXDnnK66fD8UI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C6Rj7keC; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C6Rj7keC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12FAAC2BD10;
	Fri, 17 May 2024 17:41:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715967673;
	bh=LOhCoGeoA8WzbPnd3geK65B/Qz0jnknXrCon4X8++uI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=C6Rj7keCLRtFXkgr4bVBzAyh5RfixbauMn3QWXR7UtX8kYheG6Wbex1eqkJuEpTcQ
	 toE/RsKpaLdrh1JYLqtrNoR58ktH5zGRVUZJeiM1jI8tc3b46Zh3NUg9X9xD97+OFo
	 7Kkp+8Lte6AWx7Vdrh7Hl6HrRIxoR1pOFA1somjqsLdzBTtjsCFQW63BvXdxPCiEEI
	 qXOhtJsEMQfGPitlnGdCKOla9bKSjBX71hER7MuZMHeU4MvmZaX5i9znad3qAoNfUW
	 JJeS+4N2xkP7vtlAOzXK9gL/xbKSxOVaXa4hW2xdOg481ltxay3wYagG/lv/yd2Nl+
	 YMPDtXyrDdwDg==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Fri, 17 May 2024 19:40:46 +0200
Subject: [PATCH mptcp-next 3/3] doc: new 'mptcp' page in 'networking'
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240517-mptcp-doc-v1-3-fc1ef063584e@kernel.org>
References: <20240517-mptcp-doc-v1-0-fc1ef063584e@kernel.org>
In-Reply-To: <20240517-mptcp-doc-v1-0-fc1ef063584e@kernel.org>
To: mptcp@lists.linux.dev
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=8471; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=LOhCoGeoA8WzbPnd3geK65B/Qz0jnknXrCon4X8++uI=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBmR5azZuoa0O5hhciRL/FFv5HTp1fuQdr6lu4oR
 3hKjGY2Zp+JAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZkeWswAKCRD2t4JPQmmg
 cyKUD/4tDFtfAIR7eLhPLBVoISCvqGCGtQxXvrx1cpXL2nZ+zXXj0M5TZ+nD3lneRvDfVX7oOv+
 g8vBAGS35oVP+6RXiIXtnalbCEpIk6qvLrAxqr3/1DEBRHh/7mCk7bTYsnVZCs52grNDnPiAYIp
 fxHdalZIoBwmKuOKvS0a4WYk4597H1zs9PIM27NTo06AXSqabSwobW9O/1rUj1yxUB7UJ2OS4jv
 4zCuwZcFmHG24bHtJm2ahAVbTo3KL4LwkT7FtW5ZxUCTpiuzbona/kalvp4euUoaMuB9/0RPMqV
 ZG7jZQSQw7N3UkSSyfxwAlgJYGDCx//DqQyNnaeSygpHX51u+SBOV4qvUl8hYq/zMV4p6+avMYu
 mulwdV8qtd/T1HfFv3HZ2V7Th/5swSRkVsMUYHTehGzZFxTs/k/13bwb++KuGIeJCiZroX4kPRa
 babpo7yFqXRgYkp+mAZ8ptiYSDnw0r2bdsyQY+V6HThr5qcbmOENp4QtPcrWKu+KnuB6uYVZk0O
 XvPOjTpDAhePPIOepUWFurwoYKUzs1PQHVLW71btd1SpcCS7R0+WoZ9x7dfHV5ZZLqBVsDRJsAc
 R53kV5iloTvh4XwqljdZjJ85ovkHeMzVIFXWXt0dAtv2Lq6Yt8k3bWCCts1Az5agrsU7MWJzhvk
 q/8ElrI6ixhhXeQ==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

A global documentation about MPTCP was missing since its introduction in
v5.6.

Most of what is there comes from our recently updated mptcp.dev website,
with additional links to resources from the kernel documentation.

This is a first version, mainly targeting app developers and users.

Link: https://www.mptcp.dev
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 Documentation/networking/index.rst |   1 +
 Documentation/networking/mptcp.rst | 155 +++++++++++++++++++++++++++++++++++++
 MAINTAINERS                        |   2 +-
 3 files changed, 157 insertions(+), 1 deletion(-)

diff --git a/Documentation/networking/index.rst b/Documentation/networking/index.rst
index 7664c0bfe461..a6443851a142 100644
--- a/Documentation/networking/index.rst
+++ b/Documentation/networking/index.rst
@@ -72,6 +72,7 @@ Contents:
    mac80211-injection
    mctp
    mpls-sysctl
+   mptcp
    mptcp-sysctl
    multiqueue
    multi-pf-netdev
diff --git a/Documentation/networking/mptcp.rst b/Documentation/networking/mptcp.rst
new file mode 100644
index 000000000000..cb04a553d010
--- /dev/null
+++ b/Documentation/networking/mptcp.rst
@@ -0,0 +1,155 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+=====================
+Multipath TCP (MPTCP)
+=====================
+
+Introduction
+============
+
+Multipath TCP or MPTCP is an extension to the standard TCP and is described in
+`RFC 8684 (MPTCPv1) <https://www.rfc-editor.org/rfc/rfc8684.html>`_. It allows a
+device to make use of multiple interfaces at once to send and receive TCP
+packets over a single MPTCP connection. MPTCP can aggregate the bandwidth of
+multiple interfaces or prefer the one with the lowest latency, it also allows a
+fail-over if one path is down, and the traffic is seamlessly reinjected on other
+paths.
+
+For more details about Multipath TCP in the Linux kernel, please see the
+official website: `mptcp.dev <https://www.mptcp.dev>`.
+
+
+Use cases
+=========
+
+Thanks to MPTCP, being able to use multiple paths in parallel or simultaneously
+brings new use-cases, compared to TCP:
+
+- Seamless handovers: switching from one path to another while preserving
+  established connections, e.g. to be used in mobility use-cases, like on
+  smartphones.
+- Best network selection: using the "best" available path depending on some
+  conditions, e.g. latency, losses, cost, bandwidth, etc.
+- Network aggregation: using multiple paths at the same time to have a higher
+  throughput, e.g. to combine fixed and mobile networks to send files faster.
+
+
+Concepts
+========
+
+Technically, when a new socket is created with the ``IPPROTO_MPTCP`` protocol
+(Linux-specific), a *subflow* (or *path*) is created. This *subflow* consists of
+a regular TCP connection that is used to transmit data through one interface.
+Additional *subflows* can be negotiated later between the hosts. For the remote
+host to be able to detect the use of MPTCP, a new field is added to the TCP
+*option* field of the underlying TCP *subflow*. This field contains, amongst
+other things, a ``MP_CAPABLE`` option that tells the other host to use MPTCP if
+it is supported. If the remote host or any middlebox in between does not support
+it, the returned ``SYN+ACK`` packet will not contain MPTCP options in the TCP
+*option* field. In that case, the connection will be "downgraded" to plain TCP,
+and it will continue with a single path.
+
+This behavior is made possible by two internal components: the path manager, and
+the packet scheduler.
+
+Path Manager
+------------
+
+The Path Manager is in charge of *subflows*, from creation to deletion, and also
+address announcements. Typically, it is the client side that initiates subflows,
+and the server side that announces additional addresses via the ``ADD_ADDR`` and
+``REMOVE_ADDR`` options.
+
+Path managers are controlled by the ``net.mptcp.pm_type`` sysctl knob -- see
+mptcp-sysctl.rst. There are two types: the in-kernel one (type ``0``) where the
+same rules are applied for all the connections (see: ``ip mptcp``) ; and the
+userspace one (type ``1``), controlled by a userspace daemon (i.e. `mptcpd
+<https://mptcpd.mptcp.dev/>`_) where different rules can be applied for each
+connection. The path managers can be controlled via a Netlink API, see
+netlink_spec/mptcp_pm.rst.
+
+To be able to use multiple IP addresses on a host to create multiple *subflows*
+(paths), the default in-kernel MPTCP path-manager needs to know which IP
+addresses can be used. This can be configured with ``ip mptcp endpoint`` for
+example.
+
+Packet Scheduler
+----------------
+
+The Packet Scheduler is in charge of selecting which available *subflow(s)* to
+use to send the next data packet. It can decide to maximize the use of the
+available bandwidth, only to pick the path with the lower latency, or any other
+policy depending on the configuration.
+
+Packet schedulers are controlled by the ``net.mptcp.scheduler`` sysctl knob --
+see mptcp-sysctl.rst.
+
+
+Sockets API
+===========
+
+Creating MPTCP sockets
+----------------------
+
+On Linux, MPTCP can be used by selecting MPTCP instead of TCP when creating the
+``socket``:
+
+.. code-block:: C
+
+    int sd = socket(AF_INET(6), SOCK_STREAM, IPPROTO_MPTCP);
+
+Note that ``IPPROTO_MPTCP`` is defined as ``262``.
+
+If MPTCP is not supported, ``errno`` will be set to:
+
+- ``EINVAL``: (*Invalid argument*): MPTCP is not available, on kernels < 5.6.
+- ``EPROTONOSUPPORT`` (*Protocol not supported*): MPTCP has not been compiled,
+  on kernels >= v5.6.
+- ``ENOPROTOOPT`` (*Protocol not available*): MPTCP has been disabled using
+  ``net.mptcp.enabled`` sysctl knob, see mptcp-sysctl.rst.
+
+MPTCP is then opt-in: applications need to explicitly request it. Note that
+applications can be forced to use MPTCP with different techniques, e.g.
+``LD_PRELOAD`` (see ``mptcpize``), eBPF (see ``mptcpify``), SystemTAP,
+``GODEBUG`` (``GODEBUG=multipathtcp=1``), etc.
+
+Switching to ``IPPROTO_MPTCP`` instead of ``IPPROTO_TCP`` should be as
+transparent as possible for the userspace applications.
+
+Socket options
+--------------
+
+MPTCP supports most socket options handled by TCP. It is possible some less
+common ones are not supported, but contributions are welcomed.
+
+Generally, the same value is propagated to all subflows, including the ones
+created later. eBPF can be used to set different values per subflows.
+
+There are some MPTCP specific socket options at the ``SOL_MPTCP`` (284) level to
+retrieve info. They fill the ``optval`` buffer of the ``getsockopt()`` system
+call:
+
+- ``MPTCP_INFO``: Uses ``struct mptcp_info``.
+- ``MPTCP_TCPINFO``: Uses ``struct mptcp_subflow_data``, followed by an array of
+  ``struct tcp_info``.
+- ``MPTCP_SUBFLOW_ADDRS``: Uses ``struct mptcp_subflow_data``, followed by an
+  array of ``mptcp_subflow_addrs``.
+- ``MPTCP_FULL_INFO``: Uses ``struct mptcp_full_info``, with one pointer to an
+  array of ``struct mptcp_subflow_info`` (including the
+  ``struct mptcp_subflow_addrs``), and one pointer to an array of
+  ``struct tcp_info``, followed by the content of ``struct mptcp_info``.
+
+Note that at the TCP level, ``TCP_IS_MPTCP`` socket option can be used to know
+if MPTCP is still being used: the value will be set to 1 if it is.
+
+
+Design choices
+==============
+
+A new socket type has been added for MPTCP for the userspace-facing socket. The
+kernel is in charge of creating subflow sockets: they are TCP sockets where the
+behavior is modified using TCP-ULP.
+
+MPTCP listen sockets will create "plain" *accepted* TCP sockets if the
+connection request from the client didn't ask for MPTCP, making the performance
+impact minimal when MPTCP is enabled by default.
diff --git a/MAINTAINERS b/MAINTAINERS
index 50892cdafb25..4edd8a3742f0 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -15573,7 +15573,7 @@ B:	https://github.com/multipath-tcp/mptcp_net-next/issues
 T:	git https://github.com/multipath-tcp/mptcp_net-next.git export-net
 T:	git https://github.com/multipath-tcp/mptcp_net-next.git export
 F:	Documentation/netlink/specs/mptcp_pm.yaml
-F:	Documentation/networking/mptcp-sysctl.rst
+F:	Documentation/networking/mptcp*.rst
 F:	include/net/mptcp.h
 F:	include/trace/events/mptcp.h
 F:	include/uapi/linux/mptcp*.h

-- 
2.43.0

