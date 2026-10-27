Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=165.173.180.54
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793094878;
	b=hAjmenVPoO6tKEsxkLV43UnF+WJbpuGxNkpOzv6FCXYWnk07tqpMlg9kTkjrgihptBfI
	 +a4lVO2SBONym4+0wNSLikJF0wQvut/KIucXA0WGjkCm1Ve5wf2doGavpuuDQnmJIlv3J
	 z6Ljbg37ptleqq+mdrsayJ2QvMBHEJJDR1ZvoiZstSjJFmsyCfSaRWly1P6xwnUyGyPBu
	 wBJs7RgJUZ6C2EtbwpCrzSCdMW9mTSp10fxUWdJGgoFLr8lSFrtnTl8jXjNU4DJnunVBx
	 cyFSm2MxZ/ZoT97Cf2voTFo/pShPfdHbz1/Fto0rYm2gPgsKZhypG4Oh5o8ykCCpuKA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793094878;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-ZohoMailClient;
	bh=ohKNQ2BO7cSZG4/v+7RKIVxo01xC1CmZhknvPW2l4Tc=;
	b=az2EGisdvC0s72E0WDjgQItgcR+wKb86q47GaF3HtRhBfY/gGf/AmW6XIVYWLXL5179G
	 QFeJAODJ3ZwpZard0HXzlvfPqCt4mlqjEX9FgY0iUxYTIkUuUm8YkqlG6WsDnHSgiBQLg
	 mC6RFXoTEtMfBCGK8deAtj85VEZD5bDGmANYrsBXW1a5UVS3GYs2oB0hq8SUyrdbP8qDn
	 fNDIQdgZk0voOP1CYivU1O1p7hSViaG3GRGjsYH4bnM45i3RrOiN5UUAW6hid0Ro/8dDe
	 MVBLOewCkjAt+jZ+h7zxg+TbjgJcB/F/jl4AQq8tYydHKMpwiJMKbSkq1eaXL3fIcjw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=mpiricsoftware.com;
	spf=pass smtp.mailfrom=mpiricsoftware.com;
	arc=pass header.oldest-pass=0 smtp.remote-ip=165.173.180.54
Received: from sender6-of-o54.zoho.com (sender6-of-o54.zoho.com [165.173.180.54])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 671E5606A31F
	for <mptcp@lists.linux.dev>; Tue, 27 Oct 2026 09:54:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 671E5606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mpiricsoftware.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mpiricsoftware.com
ARC-Seal: i=1; a=rsa-sha256; t=1793094869; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=OmVclmBaWF2pXJ9xJZA0kFHJTC0pNUVtJF1wzdQTMxJGJy6FrHyFoHQNB3CKXw517Z0WkJYQng+m1LrSekW4Kkulk1xVoeAhn7bigOMMgS+Gdp5Gb7dfSouoamggueVU/VsXmmQdiP8AyMsJgHWhLtcsvdy8Lvx0Ms2kL3EtlyE=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1793094869; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=ohKNQ2BO7cSZG4/v+7RKIVxo01xC1CmZhknvPW2l4Tc=; 
	b=H9KK/x4uxY/k8IGs4MsIhBFYrIbJ5HLx+rtveyy+8ZmBZXRedTJeECvWj/umyJc+e3OCkUuA4nL2O/Sqjfe9TntwxKi/R6eZ6Muh0XfrM3DzfoAeecoLoauvs5x044fTahCNFuhe2aobbdCpzxK/xlx16ZJOMsJy/WjS5qivBHE=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=mpiricsoftware.com;
	spf=pass  smtp.mailfrom=kalpan.jani@mpiricsoftware.com;
	dmarc=pass header.from=<kalpan.jani@mpiricsoftware.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1793094869;
	s=mpiric; d=mpiricsoftware.com; i=kalpan.jani@mpiricsoftware.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=ohKNQ2BO7cSZG4/v+7RKIVxo01xC1CmZhknvPW2l4Tc=;
	b=RVm+TlLT1G/IJvkEVXki0khbbenQ2NuLwuY4RpEwXk0RrhjGmA0KHxzTdYHl+Uue
	LnjpVuvuhJJZh2NPw+JR2oQXi4cFC60TINoBdGBHSciV/QGbunmgaM7RRkHgzG9NXwD
	2kOu6wzYEkwNCbj0/91uhJxO5gbN3QXEw42BtXDQ=
Received: by smtp.zohomail.com with SMTPS id 1793094866557540.9808834534165;
	Tue, 27 Oct 2026 02:54:26 -0700 (PDT)
From: Kalpan Jani <kalpan.jani@mpiricsoftware.com>
To: mptcp@lists.linux.dev
Cc: matttbe@kernel.org,
	martineau@kernel.org,
	pabeni@redhat.com
Subject: Re: [RFC net-next v10] mptcp: normalize seq numbers reported in mptcp_info
Date: Tue, 27 Oct 2026 15:24:10 +0530
Message-ID: <20261027095410.3675317-1-kalpan.jani@mpiricsoftware.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261027062750.2095515-1-kalpan.jani@mpiricsoftware.com>
References: <20261027062750.2095515-1-kalpan.jani@mpiricsoftware.com>
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

Thanks for reviewing the new version and for the suggestions.

I understand that v10 mixes two different approaches: normalizing the sequence values and hiding them from unprivileged diagnostic requests. I will separate these concerns rather than keep them bundled together.

I will first check whether the requester's CAP_NET_ADMIN status can be obtained reliably from the existing skb in inet_diag_handler_get_info(), so that we can avoid changing the idiag_get_info callback interface if possible. If that is not feasible, I will keep the generic callback change separate from the MPTCP-specific diagnostic change.

For MPTCP_SUBFLOW_ATTR_MAP_SEQ, I understand that the value should be zero for callers without CAP_NET_ADMIN. I will apply the same access-control policy consistently to the relevant MPTCP diagnostic fields.

I will also investigate whether the existing byte counters, such as bytes sent, received, and acknowledged, can provide the information needed for issue #445 without exposing the sequence counters. I will keep any required sequence-baseline fixes, including the two issues reported by Sashiko, separate from the diagnostic access-control change.

I will update the patch series after checking these points and validating the changes.

Cheers,
Kalpan
