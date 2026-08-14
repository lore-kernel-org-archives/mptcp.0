Received: from sender4-of-o54.zoho.com (sender4-of-o54.zoho.com [136.143.188.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCDCD33F5BC
	for <mptcp@lists.linux.dev>; Fri, 14 Aug 2026 05:30:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786685427; cv=pass; b=FnzbDypK8SkndnW5ZEn1XiMViGkYNCWLd631WrlENEcxQuWuBDp5Op5d8hgYpfdNdcslfeYzDKxdsqf/pJin6CTTxA6BuBfFQg/BFHPOkGb2nHYuD18L127s8G/cMLO5sAB5JUWDlRql+H1Cd71cHxS+lfpeuzj6ldW/axucP5o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786685427; c=relaxed/simple;
	bh=h5D6LvBeak+jXBvNOnhV8txbkRXIpPmWYTlGUNrIrWo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nRgzXctzVTBtayH0GWaGTLS+g1+uFf6ct69WbsMWerYCKQuakRRj7CgWrKqYYt/HdxVCqW0Q/e7bTYe1bypbZW7sgnSYFkUVM1/nWFfEVztDcd4GcKJLGu2agJOhfpGg5RZfHyxS3M6LUTVtHXmzoNAmq/BPpNXhJRdYO1ZHEL8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mpiricsoftware.com; spf=pass smtp.mailfrom=mpiricsoftware.com; dkim=fail (0-bit key) header.d=mpiricsoftware.com header.i=kalpan.jani@mpiricsoftware.com header.b=lYVAhiV+ reason="key not found in DNS"; arc=pass smtp.client-ip=136.143.188.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mpiricsoftware.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mpiricsoftware.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=mpiricsoftware.com header.i=kalpan.jani@mpiricsoftware.com header.b="lYVAhiV+"
ARC-Seal: i=1; a=rsa-sha256; t=1786685420; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=hIAyGiG5ulZ0TKAyCNt46e2B46sx5tJ8gAKvN1GvFhdzOwRsHxKTkcmOTh+CvSgfHO3qt8trBv1XFw42mayGTvAYAzKb1Y3e1xmt4gIUYz30ds4tXkxKXZ1NuQVtnZfQpjpe3kUigsfPipH1GuL9PHFhGnAuScbWNJgKviBXKgc=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1786685420; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=h5D6LvBeak+jXBvNOnhV8txbkRXIpPmWYTlGUNrIrWo=; 
	b=c275suBjA3qoQlK0HSZjPnBTaLC8PHTCF4BCSLk44qZVad5vX2GQbjhTkCnN6A9K6c6kIFFMfNq6u1Pft5XVJtAIOXuaMbR7sbNbc9oTa1/Sc8IcZjj9BUYCMsfjozoSx5NVzb44KIdYw+j8Hvch+itSqsLXO076BOEMZPU+zn0=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=mpiricsoftware.com;
	spf=pass  smtp.mailfrom=kalpan.jani@mpiricsoftware.com;
	dmarc=pass header.from=<kalpan.jani@mpiricsoftware.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1786685420;
	s=mpiric; d=mpiricsoftware.com; i=kalpan.jani@mpiricsoftware.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=h5D6LvBeak+jXBvNOnhV8txbkRXIpPmWYTlGUNrIrWo=;
	b=lYVAhiV+94ks52LMYCHyTdvTv+Ta7jSe+FOFLiCKQkOf8II4K2euf1pX+25OVWOz
	JtbaKhpL7ATDT0agYtJbMuO6/z2VIczA8WvqTl5VP+DymTG/NeWR7wpcHumq4TPudym
	Jk1MSJh+Bd0hHD5BBFYEYTxDq+k8semYmRIZyZuk=
Received: by mx.zohomail.com with SMTPS id 1786685417449505.88496095657547;
	Thu, 13 Aug 2026 22:30:17 -0700 (PDT)
From: Kalpan Jani <kalpan.jani@mpiricsoftware.com>
To: mptcp@lists.linux.dev
Cc: matttbe@kernel.org,
	martineau@kernel.org,
	pabeni@redhat.com
Subject: Gentle reminder: review request for two pending patches
Date: Fri, 14 Aug 2026 11:00:07 +0530
Message-ID: <20260814053007.89141-1-kalpan.jani@mpiricsoftware.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

Hi All,

Hope you're doing well. I wanted to send a gentle reminder about
two patches submitted for review:

1. https://lore.kernel.org/all/ba60cf65-96cb-0c76-9f72-9558accc5d6a@gmail.com/

2. https://lore.kernel.org/all/50cfda78-fed5-c866-2690-97167cab686e@gmail.com/

Please let me know if any changes are needed, or if there's anything
I can clarify to help move the review along.

Thank you for your time.

Cheers,
Kalpan Jani
