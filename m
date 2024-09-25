Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43171136E01
	for <mptcp@lists.linux.dev>; Wed, 25 Sep 2024 09:02:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727254932; cv=none; b=UyOWVXbVOK8AL7JxsW7Pyp3d18VZ77YpzRrAUzdaVysCk/edJGD+S8Ya6y8ji0vhH8S1idCAcq9RHa2NEeT/vEVIA23LVgybzJkYaAuYfd951taa1H2cGyYysmQBQVXMnfcIIMSfZVtXdDplxdlDovl2QjJcvvW4l/WSorAADyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727254932; c=relaxed/simple;
	bh=HP+9GhWeISeZmOzSM+KpO+Qw6PfiKHfCGzu6kT3pPUg=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=UENay3Fly2f6OdMz2xwaGLt2Ue8/Eeo0HVe1VwR9w5PolRlEjRo/aEmcbtPSE5jB9di9P7Y9SoeDDqmauBM5GF/z/h1zxTnwpJLH8E0MXCKqBPLBR7Awqc0oB2lXOjrtvtt5qiQrADrwG5ZnaEiaOjiVO/PAKLiFEy2zVlQ55Mw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QLp9iTDE; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QLp9iTDE"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1727254929;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=1EXiY8TY0JSas9N2B0a7Of3t8ufqBUG60o3tq8iAsl8=;
	b=QLp9iTDEUi84co062fA1iJfjacdHZCCJez72qOMKYcBi1c/hh5m0mXjoV63wbzRoTRZY+6
	BI7YzhfhYxtyr8779teQOzbHV5ppIqLdA+JY0XrYSGrNrzmZRJRFvZ8U6eUZgZks3897oF
	UJ/QiveXtQYmgi0AMFdkX2xiENcrS4k=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-528-HSqN8s3iMIKWIfw7Gti1qQ-1; Wed,
 25 Sep 2024 05:02:07 -0400
X-MC-Unique: HSqN8s3iMIKWIfw7Gti1qQ-1
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (unknown [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id E29CA194511E
	for <mptcp@lists.linux.dev>; Wed, 25 Sep 2024 09:02:06 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.45.225.57])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 019D1195608A
	for <mptcp@lists.linux.dev>; Wed, 25 Sep 2024 09:02:05 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp@lists.linux.dev
Subject: [PATCH net-next 1/4] net: implement virtio helpers to handle UDP GSO tunneling.
Date: Wed, 25 Sep 2024 11:01:49 +0200
Message-ID: <8dbdc5d2c58c0401dd080ca5ba2dae5367cef55d.1726864770.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"; x-default=true

The virtio specification are introducing support for GSO over
UDP tunnel.

This patch brings in the needed defines and the additional
virtio hdr parsing/building helpers.

The UDP tunnel support uses additional fields in the virtio hdr,
and such fields location can change depending on other negotiated
features - specifically VIRTIO_NET_F_HASH_REPORT.

Try to be as conservative as possible with the new field validation.

Signed-off-by: Paolo Abeni <pabeni@redhat.com>
---
 include/linux/virtio_net.h      | 103 ++++++++++++++++++++++++++++++++
 include/uapi/linux/virtio_net.h |  12 ++++
 2 files changed, 115 insertions(+)

diff --git a/include/linux/virtio_net.h b/include/linux/virtio_net.h
index 276ca543ef44..5cb3e1083b63 100644
--- a/include/linux/virtio_net.h
+++ b/include/linux/virtio_net.h
@@ -240,4 +240,107 @@ static inline int virtio_net_hdr_from_skb(const struct sk_buff *skb,
 	return 0;
 }
 
+static inline unsigned int virtio_l3min(bool is_ipv6)
+{
+	return is_ipv6 ? sizeof(struct ipv6hdr) : sizeof(struct iphdr);
+}
+
+static inline int virtio_net_hdr_tnl_to_skb(struct sk_buff *skb,
+					    struct virtio_net_hdr *hdr,
+					    unsigned int tnl_hdr_offset,
+					    bool little_endian,
+					    bool has_mac)
+{
+	u8 gso_tunnel_type = hdr->gso_type & VIRTIO_NET_HDR_GSO_UDP_TUNNEL;
+	unsigned int inner_nh, outer_th, inner_th;
+	unsigned int inner_l3min, outer_l3min;
+	struct virtio_net_hdr_tunnel *tnl;
+	u8 gso_inner_type;
+	bool outer_isv6;
+	int ret;
+
+	if (!gso_tunnel_type)
+		return virtio_net_hdr_to_skb(skb, hdr, little_endian);
+
+	/* Tunnel not supported/negotiated, but the hdr asks for it. */
+	if (!tnl_hdr_offset)
+		return -EINVAL;
+
+	/* Either ipv4 or ipv6. */
+	if (gso_tunnel_type & VIRTIO_NET_HDR_GSO_UDP_TUNNEL_IPV4 &&
+	    gso_tunnel_type & VIRTIO_NET_HDR_GSO_UDP_TUNNEL_IPV6)
+		return -EINVAL;
+
+	/* No UDP fragments over UDP tunnel. */
+	hdr->gso_type &= ~gso_tunnel_type;
+	gso_inner_type = hdr->gso_type & ~VIRTIO_NET_HDR_GSO_ECN;
+	if (!gso_inner_type || gso_inner_type == VIRTIO_NET_HDR_GSO_UDP_L4)
+		return -EINVAL;
+
+	/* Relay on csum being present. */
+	if (!(hdr->flags & VIRTIO_NET_HDR_F_NEEDS_CSUM))
+		return -EINVAL;
+
+	/* Validate offsets. */
+	outer_isv6 = gso_tunnel_type & VIRTIO_NET_HDR_GSO_UDP_TUNNEL_IPV6;
+	inner_l3min = virtio_l3min(gso_inner_type == VIRTIO_NET_HDR_GSO_TCPV6);
+	outer_l3min = virtio_l3min(outer_isv6);
+	if (has_mac)
+		outer_l3min += ETH_HLEN;
+
+	tnl = ((void *)hdr) + tnl_hdr_offset;
+	inner_th = __virtio16_to_cpu(little_endian, hdr->csum_start);
+	inner_nh = __virtio16_to_cpu(little_endian, tnl->inner_nh_offset);
+	outer_th = __virtio16_to_cpu(little_endian, tnl->outer_th_offset);
+	if (outer_th < outer_l3min + sizeof(struct udphdr) ||
+	    outer_th > inner_nh ||
+	    inner_th < inner_nh + inner_l3min)
+		return -EINVAL;
+
+	/* Let the basic parsing deal with plain GSO features. */
+	ret = virtio_net_hdr_to_skb(skb, hdr, little_endian);
+	if (ret)
+		return ret;
+
+	skb_set_inner_protocol(skb, outer_isv6 ? htons(ETH_P_IPV6) :
+						 htons(ETH_P_IP));
+	skb_shinfo(skb)->gso_type |= SKB_GSO_UDP_TUNNEL;
+	skb->inner_transport_header = inner_th;
+	skb->inner_network_header = inner_nh;
+	skb->transport_header = outer_th;
+	return 0;
+}
+
+static inline int virtio_net_hdr_tnl_from_skb(struct sk_buff *skb,
+					      struct virtio_net_hdr *hdr,
+					      unsigned int tnl_hdr_offset,
+					      bool little_endian,
+					      int vlan_hlen)
+{
+	struct virtio_net_hdr_tunnel *tnl;
+	int ret;
+
+	if (!(skb_shinfo(skb)->gso_type & SKB_GSO_UDP_TUNNEL))
+		return virtio_net_hdr_from_skb(skb, hdr, little_endian, false,
+					       vlan_hlen);
+
+	skb_shinfo(skb)->gso_type &= ~SKB_GSO_UDP_TUNNEL;
+	ret = virtio_net_hdr_from_skb(skb, hdr, little_endian, false,
+				      vlan_hlen);
+	if (ret)
+		return ret;
+
+	if (skb->protocol == htons(ETH_P_IPV6))
+		hdr->gso_type |= VIRTIO_NET_HDR_GSO_UDP_TUNNEL_IPV6;
+	else
+		hdr->gso_type |= VIRTIO_NET_HDR_GSO_UDP_TUNNEL_IPV4;
+
+	tnl = ((void *)hdr) + tnl_hdr_offset;
+	tnl->inner_nh_offset =  __cpu_to_virtio16(little_endian,
+						  skb->inner_network_header);
+	tnl->outer_th_offset =  __cpu_to_virtio16(little_endian,
+						  skb->transport_header);
+	return 0;
+}
+
 #endif /* _LINUX_VIRTIO_NET_H */
diff --git a/include/uapi/linux/virtio_net.h b/include/uapi/linux/virtio_net.h
index ac9174717ef1..e9b3853312a8 100644
--- a/include/uapi/linux/virtio_net.h
+++ b/include/uapi/linux/virtio_net.h
@@ -56,6 +56,8 @@
 #define VIRTIO_NET_F_MQ	22	/* Device supports Receive Flow
 					 * Steering */
 #define VIRTIO_NET_F_CTRL_MAC_ADDR 23	/* Set MAC address */
+#define VIRTIO_NET_F_GUEST_UDP_TUNNEL_GSO 47 /* Guest can handle GSO over UDP tunnel */
+#define VIRTIO_NET_F_HOST_UDP_TUNNEL_GSO 49 /* Host can handle GSO over UDP tunnel */
 #define VIRTIO_NET_F_DEVICE_STATS 50	/* Device can provide device-level statistics. */
 #define VIRTIO_NET_F_VQ_NOTF_COAL 52	/* Device supports virtqueue notification coalescing */
 #define VIRTIO_NET_F_NOTF_COAL	53	/* Device supports notifications coalescing */
@@ -137,6 +139,10 @@ struct virtio_net_hdr_v1 {
 #define VIRTIO_NET_HDR_GSO_UDP		3	/* GSO frame, IPv4 UDP (UFO) */
 #define VIRTIO_NET_HDR_GSO_TCPV6	4	/* GSO frame, IPv6 TCP */
 #define VIRTIO_NET_HDR_GSO_UDP_L4	5	/* GSO frame, IPv4& IPv6 UDP (USO) */
+#define VIRTIO_NET_HDR_GSO_UDP_TUNNEL_IPV4 0x20 /* UDP over IPv4 tunnel present */
+#define VIRTIO_NET_HDR_GSO_UDP_TUNNEL_IPV6 0x40 /* UDP over IPv6 tunnel present */
+#define VIRTIO_NET_HDR_GSO_UDP_TUNNEL (VIRTIO_NET_HDR_GSO_UDP_TUNNEL_IPV4 | \
+				       VIRTIO_NET_HDR_GSO_UDP_TUNNEL_IPV6)
 #define VIRTIO_NET_HDR_GSO_ECN		0x80	/* TCP has ECN set */
 	__u8 gso_type;
 	__virtio16 hdr_len;	/* Ethernet + IP + tcp/udp hdrs */
@@ -181,6 +187,12 @@ struct virtio_net_hdr_v1_hash {
 	__le16 padding;
 };
 
+/* This header after hashing information */
+struct virtio_net_tunnel_hdr {
+	__virtio16 outer_th_offset;
+	__virtio16 inner_nh_offset;
+};
+
 #ifndef VIRTIO_NET_NO_LEGACY
 /* This header comes first in the scatter-gather list.
  * For legacy virtio, if VIRTIO_F_ANY_LAYOUT is not negotiated, it must
-- 
2.45.2

