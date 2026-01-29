Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E9A725A2B4
	for <mptcp@lists.linux.dev>; Thu, 29 Jan 2026 04:13:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769660012; cv=none; b=n4DuMIite1WvPwoSoQITl20+SZ/WFnS1z0OX4XXbVJ7m7VG0q3E6AgkSUMVV+7Pqro55gMGhluMU7D5+xVvIjpoOOBej/0BytEo88pYCUB0akuXlrSvBDIWJz0Un49pZL0QuuhvoGqXpn50fYUf6ZC+bbEoro5Y4regszDXQGpM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769660012; c=relaxed/simple;
	bh=16NXzws07wBEbi4IFY3RE/UJffRBueNUf690k9YmV+4=;
	h=Message-ID:Subject:From:To:Cc:Date:Content-Type:MIME-Version; b=bMVKLbLD414PI6Zum00gPVvmFOx2Osrb1+goQgkQTn+lXL2zlP3wlJTvOIcwnQwnirY9Rjw6JKjLjDhjfM6q9PLp4Xett+Q/rtBlfC39Pvvh4Cdx+qTXmbylX2C+YI2FFuHBycIAVaB87EkWxbXBGYgWX/pXwE5gBTmUJUF1P2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BQFVekOO; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BQFVekOO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BAD40C116D0;
	Thu, 29 Jan 2026 04:13:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769660012;
	bh=16NXzws07wBEbi4IFY3RE/UJffRBueNUf690k9YmV+4=;
	h=Subject:From:To:Cc:Date:From;
	b=BQFVekOO1U59dCPC9kqojQyn0ts8UY5Azo1JWxdrVD8stsljKBzIPUQ1ddPj17x+r
	 5InQ0LfMZIHfRxr74TmJkLH2BpNyUAcKG6flvZVhM9mqAMk0m6AjksVnidaAUw1y2E
	 +D5fn+dbHG2VCtwheldxIBQN4BiXhTUUhmsj1b/n/fcI/kamGQWukQ7DTCGtpsm7ye
	 F+9sTEjzuL5TL9VhJZP9qMzAMK2isH2SmibV1qsttRtvU3aSSh+Z8+pZQf1HZknf6t
	 xAqf0HDEY1u5dIKOLdY5VkkmiRwaKNy2X3hDwzvLMT1/U24FuY/jEDSwGWqpnVPdj6
	 1hyKnQfyEsAXw==
Message-ID: <a9f115aa5719e1088702a3fdeee766a3166611b1.camel@kernel.org>
Subject: [LSF/MM/BPF TOPIC] NVMe over MPTCP: Multi-Fold Acceleration for
 NVMe over TCP in Multi-NIC Environments
From: Geliang Tang <geliang@kernel.org>
To: lsf-pc@lists.linux-foundation.org, linux-nvme@lists.infradead.org
Cc: mptcp@lists.linux.dev, Matthieu Baerts <matttbe@kernel.org>, Mat
 Martineau	 <martineau@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Hannes
 Reinecke	 <hare@suse.de>
Date: Thu, 29 Jan 2026 12:13:25 +0800
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.56.2-4 
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

As one of the MPTCP upstream developers, I'm recently working on adding
MPTCP support to 'NVMe over TCP'. This approach achieves a multi-fold
performance improvement over using standard TCP. The implementation and
testing phases are largely complete. The code is currently in the RFC
stage and has undergone several rounds of discussion and iteration on
the MPTCP mailing list [1]. It will be sent to the NVMe mailing list
shortly.

1. Introduction to MPTCP

Multipath TCP (MPTCP), standardized in RFC 8684, represents a major
evolution of the TCP protocol. It enables a single transport connection
to utilize multiple network paths simultaneously, providing benefits in
redundancy, resilience, and bandwidth aggregation. Since its
introduction in Linux kernel v5.6, it has become a key technology for
modern networking, particularly in multi-NIC environments.

On a supported system such as Linux, an MPTCP socket is created by
specifying the IPPROTO_MPTCP protocol in the socket() system call:

	int fd = socket(AF_INET, SOCK_STREAM, IPPROTO_MPTCP);

This creates a socket that appears as a standard TCP socket to the
application but uses the MPTCP protocol stack underneath.

For more details, please visit the project website: https://mptcp.dev.

2. Implementation

'NVMe over TCP' establishes multiple TCP connections between the target
and host for data transfer. This includes one admin queue connection
for management traffic and multiple I/O queue connections for data
traffic, with the number typically scaling with available CPU cores.
While these multiple TCP connections (using the same IP address but
different ports) help distribute computational load across CPUs, all
data traffic still flows through a single network interface card (NIC),
even in multi-NIC environments.

The 'NVMe over MPTCP' solution enhances 'NVMe over TCP' by replacing
the multiple TCP connections with multiple MPTCP connections, leaving
other mechanisms unchanged. Internally, each MPTCP connection can
establish multiple subflows based on the number of configured NICs.
This distributes data traffic across all available NICs, thereby
increasing aggregate transmission speed.

Therefore, the primary change required is to modify the protocol
parameter from IPPROTO_TCP to IPPROTO_MPTCP when creating sockets on
both the target and host sides:

	Target side:

	sock_create(port->addr.ss_family, SOCK_STREAM,
			IPPROTO_TCP, &port->sock);

	Host side:

	sock_create_kern(current->nsproxy->net_ns,
			ctrl->addr.ss_family, SOCK_STREAM,
			IPPROTO_TCP, &queue->sock);

A new NVMe transport type, named NVMF_TRTYPE_MPTCP (suggested by Hannes
Reinecke), has been introduced to determine whether to create a TCP or
MPTCP socket:

	Target side:

	if (nport->disc_addr.trtype == NVMF_TRTYPE_MPTCP)
		proto = IPPROTO_MPTCP;

	Host side:

	if (!strcmp(ctrl->ctrl.opts->transport, "mptcp"))
		proto = IPPROTO_MPTCP;

3. Performance Benefits

This new feature has been evaluated in different environments:

I conducted 'NVMe over MPTCP' tests between two PCs, each equipped with
two Gigabit NICs and directly connected via Ethernet cables. Using
'NVMe over TCP', the fio benchmark showed a speed of approximately 100
MiB/s. In contrast, 'NVMe over MPTCP' achieved about 200 MiB/s with
fio, doubling the throughput.

In a virtual machine test environment simulating four NICs on both
sides, 'NVMe over MPTCP' delivered bandwidth up to four times that of
standard TCP.

4. Configuration

To achieve the described multi-fold acceleration benefits, both the
target and host sides must be deployed in multi-NIC environments with
properly configured MPTCP endpoints. The target side should use the
'signal' flag for its endpoints, while the host side should use the
'subflow' flag.

	Target side:

	# ip mptcp endpoint add 192.168.1.2 id 2 dev enp3s0f1 signal
	# echo mptcp > /sys/kernel/config/nvmet/ports/1234/addr_trtype

	Host side:

	# ip mptcp endpoint add 192.168.1.4 id 2 dev enp1s0f1 subflow
	# nvme discover -t mptcp ...
	# nvme connect -t mptcp ...

5. Dependencies

The modifications in the NVMe subsystem are minimal. Most of the code
change is on the MPTCP side, to implement interfaces to use MPTCP from
the kernel space, similar to what is done today with TCP.

'NVMe over TCP' uses the read_sock interface for data receiving.
Consequently, the read_sock interface for MPTCP has been implemented
('implement mptcp read_sock' series [2]), which is under review on the
MPTCP mailing list.

As 'NVMe over TCP' can utilize TLS for encryption, KTLS support for
MPTCP has also been added ('MPTCP KTLS support' series [3]), which is
currently in the RFC stage. TLS mode for 'NVMe over MPTCP' has been
successfully validated.

Corresponding updates are also required in user-space libraries and
tools, including libnvme [4], nvme-cli [5], and ktls-utils [6], to add
MPTCP support.

6. Discussion

The current approach is to define a new transport type,
NVMF_TRTYPE_MPTCP, but I understand it will need to register a new
protocol number from NVMexpress.org. Hannes Reinecke also suggested
declaring MPTCP as a TCP 'variant', but I found some drawbacks. I would
like to discuss them and find possible solutions.

I also seek guidance on how to incorporate MPTCP support into the NVMe
protocol specifications. I lack experience in modifying NVMe protocol
specifications and would appreciate guidance and assistance from the
NVMe community.

Thanks,
-Geliang

[1]
NVME over MPTCP
https://patchwork.kernel.org/project/mptcp/cover/cover.1764152990.git.tanggeliang@kylinos.cn/
[2]
implement mptcp read_sock
https://patchwork.kernel.org/project/mptcp/cover/cover.1765023923.git.tanggeliang@kylinos.cn/
[3]
MPTCP KTLS support
https://patchwork.kernel.org/project/mptcp/cover/cover.1768294706.git.tanggeliang@kylinos.cn/
[4]
libnvme: add mptcp trtype
https://patchwork.kernel.org/project/mptcp/patch/99f6e63b5c9677f29a9bc8cdd87b2064b258435f.1764206766.git.tanggeliang@kylinos.cn/
[5]
fabrics: add mptcp support
https://github.com/linux-nvme/nvme-cli/commit/f468531d0592ad22b71760d883409363b1f8a9d6
[6]
add mptcp support
https://github.com/oracle/ktls-utils/commit/4a45e486c65be986ef349ed10b0fc9bd5dbf107d

