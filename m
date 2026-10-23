Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=165.173.182.54
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792745041;
	b=cpM93QcJd1xtoO6KPJspB1W2pV4ZVza+kdJPNDiCHgb85zvIRcLWowv6E4yJ0LxkIcoB
	 uKNwl6t6Gv+rsvLPYaeUjU/pUAvpTHEBkHbM44INhC8iTYSF6lzZRDXV9XB3xNyXM/3bl
	 06AJuzDmoSUP0E3Ax4732boBA4EpMINyWrT+d4qQYoGKgpEyWCa3lNPHYZk86gFVRYFa6
	 JmojhUjm6xgA8ybAD3eViXCL1pYUpN5zqnB4q1Nx0FcIZ0sg0knxMMZdnze/VkoHTHhA6
	 T+0LuFqkr8yXNSdKWz2rH93+XMZyuxfJLmIDcXcoZoopJ6BFSEXvCB7ohFQCpGhNIiw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792745041;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-ZohoMailClient;
	bh=K3VWJ+yMg6qfGbr/YEKj4iTmvv4zVHdvGY7QNJzfzL4=;
	b=ibrBneaC3xtqMVnLdI+H1nQdPsNz8L1KRCA5hXe5RXL46jr7zCMyqhAZzS3Fo7PLQ2fU
	 9DjKH9pQKB8PZinjltZjXyEcxtrwEccw1unSDRe53VJPKH7L80mQFWEPoMWJDfwW67g5t
	 LIQTjp/NL9Gmf6tQ/KRpABLAusAAxhUEc6coP0Nd/l6sZCu3mi+CCppDtzkPuBmh8ctOf
	 9M8/VffjHvAEa5mHbC4FZM1JS91fiT6rEN8/HxeDDwnanE8t8oDpVkjX+6DaEElinZ8S2
	 rLHVYPYFFrjoToh/I+iYYt1sbncsPap1doOb9IfdRrdzKqrhCq1fdVUglSfrhWBaESg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=mpiricsoftware.com;
	spf=pass smtp.mailfrom=mpiricsoftware.com;
	arc=pass header.oldest-pass=0 smtp.remote-ip=165.173.182.54
Received: from sender5-of-o54.zoho.com (sender5-of-o54.zoho.com [165.173.182.54])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E19C606A31A
	for <mptcp@lists.linux.dev>; Fri, 23 Oct 2026 08:44:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9E19C606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mpiricsoftware.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mpiricsoftware.com
ARC-Seal: i=1; a=rsa-sha256; t=1792745036; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=bumvkIf9SWhGReWLtdwm07WxvYydsSWcQFxFCoVEm0NfmU3qCk9tl1pLU2qL3k+iRu2xWkGFhhqcCkV9wlithtcbHhjZvk9wmGrpeNVJFZC1OLrcGBC8d/NOdOQ+e75TWGzCd8fduT3bXj5nECGMR3FRPdzkVhH2c8r+hwTTrDk=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1792745036; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=K3VWJ+yMg6qfGbr/YEKj4iTmvv4zVHdvGY7QNJzfzL4=; 
	b=VuSFZFZd9ArAQlhKeAMuqCYlQrCPB8U9FvGywxwnOV1Y2G4wZh2a/80sLWbF2UJCkcxBnLbdKs23WGMx8TdrO64vpP4pDXOLWflXDhzlBb0m34bsTfvra8FDLB5Eqa0y6tmx7prw0YuH7RQ8dEXfjjSUFym7CIr46vEQ7WpglC8=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=mpiricsoftware.com;
	spf=pass  smtp.mailfrom=kalpan.jani@mpiricsoftware.com;
	dmarc=pass header.from=<kalpan.jani@mpiricsoftware.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1792745036;
	s=mpiric; d=mpiricsoftware.com; i=kalpan.jani@mpiricsoftware.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=K3VWJ+yMg6qfGbr/YEKj4iTmvv4zVHdvGY7QNJzfzL4=;
	b=gzbguFFIQnnmPUgcIyVofIP6OqnbDrIMR9til1fZUrhFGpiFKW3kXHRc4wnkro2k
	XtXZvDaNfJjI3wDl9bG17SNU4C8Llc1pAUS8henW5nsgwvDEnNOZYJBBvgCsEE6wHHN
	Zx/UrMpXqT3vjxHEji8XsWkRcqPgn+zmTs2G8jKU=
Received: by smtp.zohomail.com with SMTPS id 179274503434230.087143834634617;
	Fri, 23 Oct 2026 01:43:54 -0700 (PDT)
From: Kalpan Jani <kalpan.jani@mpiricsoftware.com>
To: mptcp@lists.linux.dev
Cc: matttbe@kernel.org,
	martineau@kernel.org,
	pabeni@redhat.com
Subject: Re: [PATCH net-next v9] mptcp: normalize seq numbers reported in mptcp_info
Date: Fri, 23 Oct 2026 14:13:40 +0530
Message-ID: <20261023084340.665126-1-kalpan.jani@mpiricsoftware.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <179219616568.3135.11934165875223757638@kernel.org>
References: <179219616568.3135.11934165875223757638@kernel.org>
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Post: <mailto:mptcp@lists.linux.dev>
List-Help: <mailto:mptcp+help@lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
List-Owner: <mailto:mptcp+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

Hi Matt,

Thanks for discussing this with Mat and for the suggestions.

I understand the main goal is to avoid exposing these sequence counters through the diag interface.

I think keeping the normalized values available through the MPTCP_INFO socket option, while handling these fields separately for inet_diag, could be a reasonable approach.

Before updating the patch, could you clarify whether you would prefer:
- Setting the relevant fields to 0 only when the user lacks CAP_NET_ADMIN, or
- Always setting them to 0 for the diag interface?

I will also look into whether the byte counters could provide the required values correctly, particularly for snd_una and retransmissions.

For MAP_SEQ, I will account for its relationship with the diagnostic interface when preparing the change.

Date: 23 October 2026

Cheers,
Kalpan
