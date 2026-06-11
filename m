Received: from sender4-of-o54.zoho.com (sender4-of-o54.zoho.com [136.143.188.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E36DA3358B6
	for <mptcp@lists.linux.dev>; Thu, 11 Jun 2026 06:59:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781161180; cv=pass; b=JrDWhV/rJyfb0Llu/fcsJzvZsY7+10kO3Lez8qDphZhgZrY03MdT9NBn8p2nFOJNuCpoygDftB0/NhBqyA3RWzPr9jqKLLhy7QgM5lGX04GURsONrVGW+eo89IqAUn5ZEuvZ7N1+ViDW3u2xSQoRk4k6l1IHYJ9+PS78N8r/LJA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781161180; c=relaxed/simple;
	bh=Xwvs3Xu7eTiAcpjuAXo7Dqxs1BxRvMGMCdJvY8euhx8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LKO7p9cfKMSKK2ncakqxvZIQqr4dPFQ7nbrF7I42kD8BwDUmH/XQcOasHeKz2BYugr0viJ+l/dWm975n7/HZTffiJmtneIQ648U8IcA0s41YZawKkwVaiBNiJycs2MJdKUcGevswgzzwgrSjcs7s0DOw3AOziqt7FwZ2sfmB6jQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mpiricsoftware.com; spf=pass smtp.mailfrom=mpiricsoftware.com; dkim=fail (0-bit key) header.d=mpiricsoftware.com header.i=kalpan.jani@mpiricsoftware.com header.b=jJLkFXO3 reason="key not found in DNS"; arc=pass smtp.client-ip=136.143.188.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mpiricsoftware.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mpiricsoftware.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=mpiricsoftware.com header.i=kalpan.jani@mpiricsoftware.com header.b="jJLkFXO3"
ARC-Seal: i=1; a=rsa-sha256; t=1781161177; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=Lb7LzycNsQzx+T4OwVk/kLtDp25uBR6uhPS/h+2oat2Zt6RE3Tz35DkyHP/Lb8wXr7P/8L7HHNbKLwOKGGt5InUG5vqr9w6BYYMjL+CvrIZa4mjsqTKWFP/aiWzUd5nO5H7pl5ik1Kc3xA8IYI1UwvO1dllv8IngkJ4T+Of9bVo=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1781161177; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=AOTxWBRC2u0iUSkRUV0v3vaVSgu7pEkLb9S+XXsmc80=; 
	b=PuuXEmgsYI9W+M4CY1Jre7o3KPS/7k2YRa1Bpd9CvGMbgX9GKmIEojWQWq0gMODoUVgsP7Ao1RB0x7sGp2Oc3h4RWIKaZgtHolQD8p2sr2Wx1R499HZbGw0B7pUvlE/IZuAbrLusP+/yVk4bN4GJs/A7DvxKiB9oG5sEAaRHKxw=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=mpiricsoftware.com;
	spf=pass  smtp.mailfrom=kalpan.jani@mpiricsoftware.com;
	dmarc=pass header.from=<kalpan.jani@mpiricsoftware.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1781161177;
	s=mpiric; d=mpiricsoftware.com; i=kalpan.jani@mpiricsoftware.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=AOTxWBRC2u0iUSkRUV0v3vaVSgu7pEkLb9S+XXsmc80=;
	b=jJLkFXO3cENot9wzHU9AbFogSbiT8Pa+gVIs3ccMXSBWpZBSSLqffNUqylmJafh6
	O0+xEcPQyDNInR9sskj5xCzb21k15zA/hIePj4gI58Bevgi6npXi9ISzTZEXj8HZei7
	YsKYTBAvBPxATEJwvk9Q6zdrh95Dh1EFouL2muVQ=
Received: by mx.zohomail.com with SMTPS id 1781161176070248.96908813936625;
	Wed, 10 Jun 2026 23:59:36 -0700 (PDT)
From: Kalpan Jani <kalpan.jani@mpiricsoftware.com>
To: xiasonglee@gmail.com
Cc: lixiasong1@huawei.com,
	mptcp@lists.linux.dev,
	matttbe@kernel.org,
	janak@mpiric.us,
	shardul.b@mpiricsoftware.com
Subject: Re: [PATCH mptcp-net] mptcp: prevent add_addr timer rearm during teardown
Date: Thu, 11 Jun 2026 12:29:26 +0530
Message-ID: <20260611065931.466830-1-kalpan.jani@mpiricsoftware.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260526103647.732350-1-xiasong.lee@gmail.com>
References: <20260526103647.732350-1-xiasong.lee@gmail.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=y
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

Hi Li,
 
Thank you for that detailed explanation! I researched the commit 8143a224785c
that introduced timer_done, and I now fully understand the self-wait deadlock
scenario you described.
 
You're absolutely right:
 
When the socket is only held by the timer, and the callback decides not to
reschedule, the sock_put() at the end triggers sk_free(). This in turn calls
sk_stop_timer_sync() on the same timer while the callback is still running,
causing a deadlock.
 
The timer_done flag is the safeguard against this. While I correctly identified
the unsynchronized read as a data race, I failed to understand that this flag
serves a critical safety function beyond just preventing re-arms.
 
My suggestion to remove timer_done without addressing the self-wait scenario
would reintroduce the deadlock bug that commit fixed.
 
Your current approach - using sk_shutdown_timer_sync() while keeping the
timer_done check - is the right balance:
✓ Improved robustness (shutdown_sync is more explicit)
✓ Protection against self-wait (timer_done check)
✓ No new deadlock risks
 
I apologize for not thinking through this scenario fully. Your patch is solid,
and I support it as-is.
 
Thanks for the thorough review and explanation!
 
Cheers,
Kalpan
