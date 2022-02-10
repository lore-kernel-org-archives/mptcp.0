Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3006F2C9D
	for <mptcp@lists.linux.dev>; Thu, 10 Feb 2022 18:49:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1644518970;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3UBJflAZ80wm6ItZgAyOxnQGEwFP1voeDFnm8/KOqyg=;
	b=jUThGW0y/22X4hZ137ieN2lBc4hlsWgn2/Lhf3+JAH5g4ZpvAXF2ZYCXDN9IRkLrBLTjKD
	zQzS7Zz7XlkkPUrue2ouaR6IO1pnjsCNzvzRVKP0MPgjbCLf+QPGyNLxi7Zdl2eU6Ux9na
	FFq9/d2o2RMrt17qu70KDXyaMBDmzmI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-390-ecHu_qElN5eVG4wPu0twwg-1; Thu, 10 Feb 2022 13:49:29 -0500
X-MC-Unique: ecHu_qElN5eVG4wPu0twwg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 40D92802B7A
	for <mptcp@lists.linux.dev>; Thu, 10 Feb 2022 18:49:28 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.39.194.220])
	by smtp.corp.redhat.com (Postfix) with ESMTP id A5510106C0D2
	for <mptcp@lists.linux.dev>; Thu, 10 Feb 2022 18:49:27 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp@lists.linux.dev
Subject: [PATCH v3 mptcp-next 1/3] Squash-to: "mptcp: constify a bunch of of helpers"
Date: Thu, 10 Feb 2022 19:49:15 +0100
Message-Id: <f63ac7eafde9820e4a85e4f9d09630509e42119c.1644518737.git.pabeni@redhat.com>
In-Reply-To: <cover.1644518737.git.pabeni@redhat.com>
References: <cover.1644518737.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Authentication-Results: relay.mimecast.com;
	auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pabeni@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"

There are a few more helpers that can be const-ified and I missed
in the previous patch, just squash these change into there.

Signed-off-by: Paolo Abeni <pabeni@redhat.com>
---
 net/mptcp/pm_netlink.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index 46346f009485..56f5603c10f2 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -1289,7 +1289,7 @@ int mptcp_pm_get_flags_and_ifindex_by_id(struct net *net, unsigned int id,
 }
 
 static bool remove_anno_list_by_saddr(struct mptcp_sock *msk,
-				      struct mptcp_addr_info *addr)
+				      const struct mptcp_addr_info *addr)
 {
 	struct mptcp_pm_add_entry *entry;
 
@@ -1304,7 +1304,7 @@ static bool remove_anno_list_by_saddr(struct mptcp_sock *msk,
 }
 
 static bool mptcp_pm_remove_anno_addr(struct mptcp_sock *msk,
-				      struct mptcp_addr_info *addr,
+				      const struct mptcp_addr_info *addr,
 				      bool force)
 {
 	struct mptcp_rm_list list = { .nr = 0 };
-- 
2.34.1

