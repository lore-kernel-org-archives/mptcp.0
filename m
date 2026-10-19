Received: from sender5-of-o54.zoho.com (sender5-of-o54.zoho.com [165.173.182.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4BE33E49DB
	for <mptcp@lists.linux.dev>; Mon, 19 Oct 2026 11:17:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=165.173.182.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792408626; cv=pass; b=KoMIh7LpCcdOyqgCzwhvudnEyh3dZPXO6OKlc9oEYL6KgO3e3FBlUL+l2n0TpjUa87a4oN3tjPuqCZQVMpaVpzVG/dfozIJm+uWQVp/9JPbXs8sNk2Sb3zien4bYVZl+CYRZ8ntLqGxA1XI0AxGLwh7ByFdUnC21luGXG0fHLSg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792408626; c=relaxed/simple;
	bh=UJCYsjXRe7Kqdkq4oI+nSxMn8ySHlb888RlgvRsDTgM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cayGKoKmVvAoOMCFPkfIFf7xKnl5/4peIHvHKUgJzXprikr1MvUkFxhcBzLEolIuexgL8VV3lOPLYKrWQm8uENzZTVgBPfvIIJ7SZqagfyH1QLS0wFCaYmhGumkTUFip+lVJ5JtBzKX8xGiE39jG5SQn0ZaJp9mZyC1Qm1J16rs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mpiricsoftware.com; spf=pass smtp.mailfrom=mpiricsoftware.com; dkim=fail (0-bit key) header.d=mpiricsoftware.com header.i=kalpan.jani@mpiricsoftware.com header.b=USYxAJow reason="key not found in DNS"; arc=pass smtp.client-ip=165.173.182.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mpiricsoftware.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mpiricsoftware.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=mpiricsoftware.com header.i=kalpan.jani@mpiricsoftware.com header.b="USYxAJow"
ARC-Seal: i=1; a=rsa-sha256; t=1792408610; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=HXfwG6MkDj7Csri+P7opVVNSHdec87H8n+6a5CaPoN9QDrlcXqWrbSX1qrKufXSJU62u2tVJ85/ut1L+Pdp+O9ezaEno7Td0zu0wVw6naV391WrVDhCgRn4rLAVajvOTWgupWSB+jLvlahVlaESDxZ16sQsjA7bnTY4GTh+zKCQ=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1792408610; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=UJCYsjXRe7Kqdkq4oI+nSxMn8ySHlb888RlgvRsDTgM=; 
	b=C5hOexcTs0bGk6g9fCFGx4z8RBwPnuL5BT7WhCMBg2gKH/7gI1qcmv8Ei+2atMqTVTLODyDqiU3VeZ27rLnE5Bo4Ocx66X+pdqiNukzmY3iXqpnHTF3+t2Wayob5aikyFBAn2vkskJY1PTwDqzmiT6aniLwQym4G3MqcN/Sq2mA=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=mpiricsoftware.com;
	spf=pass  smtp.mailfrom=kalpan.jani@mpiricsoftware.com;
	dmarc=pass header.from=<kalpan.jani@mpiricsoftware.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1792408610;
	s=mpiric; d=mpiricsoftware.com; i=kalpan.jani@mpiricsoftware.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=UJCYsjXRe7Kqdkq4oI+nSxMn8ySHlb888RlgvRsDTgM=;
	b=USYxAJowHprnTerq81IXBDcoK4yCzoXlQ0QW7uZkT3yI5FtBGsFmCtwpMcfui/zo
	DElhsGh97WvFIDIy/nF5MHcVnIsUpntOkkzIKGASuvSz5Xmq7+dcLeE1vv6hQWlBtOV
	qcSIDNOqHvdpGmc73FQdjCAsezXwMQPhszbmswEQ=
Received: by smtp.zohomail.com with SMTPS id 1792408608411460.29439617267997;
	Mon, 19 Oct 2026 04:16:48 -0700 (PDT)
From: Kalpan Jani <kalpan.jani@mpiricsoftware.com>
To: mptcp@lists.linux.dev
Cc: Kalpan Jani <kalpan.jani@mpiricsoftware.com>,
	matttbe@kernel.org,
	martineau@kernel.org,
	pabeni@redhat.com
Subject: Re: [PATCH net-next v9] mptcp: normalize seq numbers reported in mptcp_info
Date: Mon, 19 Oct 2026 16:46:29 +0530
Message-ID: <20261019111637.27002-1-kalpan.jani@mpiricsoftware.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <179219616568.3135.11934165875223757638@kernel.org>
References: <179219616568.3135.11934165875223757638@kernel.org>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

Hi all,

Thanks for the report.

I looked into both observations.

For the first one, I see the concern about reading the sequence number and its baseline in separate synchronization windows. The connect and disconnect paths also need to be considered when deciding how to keep these values consistent. I have not made a locking change yet, as I want to avoid introducing a locking issue while addressing this.

For the second one, I noticed that mptcpi_rcv_nxt is now reported relative to remote_idsn, while MPTCP_SUBFLOW_ATTR_MAP_SEQ still reports the absolute sequence number. I have not changed the MAP_SEQ attribute, since that would affect an existing diagnostic interface.

Would documenting the normalized sequence numbers in struct mptcp_info be sufficient, or do you think any further changes are needed?

I would appreciate your suggestions on the appropriate approach before I prepare the next version.

Cheers,
Kalpan Jani
