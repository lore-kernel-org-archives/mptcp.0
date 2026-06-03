Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57FE43FC5C8
	for <mptcp@lists.linux.dev>; Wed,  3 Jun 2026 07:27:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780471634; cv=none; b=cnCXGzs7f/irty99SxESggzNl4eAFgS8QL+HTzw6yHQa0aN0J1EVwEqsgpTh4OkrzkoX/iZxv1TnkAnKS8eTbEtsNwVCHDPo9P83wcktqqHof9jClsollCgwWavv4Asr+dRLWEFR624+QDmvNWXlb65lDQIZjebr+qYJF+87EiI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780471634; c=relaxed/simple;
	bh=+YbUha5FLUoue42vpS9ik7vwJ8lgl/TB+g0FodAk7pI=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:References:
	 In-Reply-To:Content-Type; b=KeTOTQorx/DU2Aj/3GZAzYHejFKzqvVmxmPIQbQ23c2RBuAj7053t1vo3nN9FoCBua8POPpCrg31Ts6eus2TJC82dMWy6CjbBLVT6z1hEiKZxQzI6EJh4CZnqGbg2AHn4U7RWeTRKUpkDDq7umo8KGWqeLgzaMG3H9bUX+EdfzQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XMffioN+; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XMffioN+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1780471630;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rKk0RBgnQ6QXPdgrmLsS0YtUrEoiTVTsgf6dX3VDE9o=;
	b=XMffioN+DgzC0SjYJAd5AfM+VdYr+U9HsnaH4jOyrWxR4LQdcm46xOavYlAT7l4iVHiSP1
	966uszTM/UMv7GTIl5SlCaGsDALqSpeKnzOPqiDJ08i78pM0d2gtb7/OMkWPJwcLQ8nFW4
	xfMaF08wd6SS+1/QWYcDzKisKM7dEm4=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-343-J47XIICSP8GDsLUr1qo_Cw-1; Wed, 03 Jun 2026 03:27:08 -0400
X-MC-Unique: J47XIICSP8GDsLUr1qo_Cw-1
X-Mimecast-MFC-AGG-ID: J47XIICSP8GDsLUr1qo_Cw_1780471627
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-490afe64f26so1718235e9.0
        for <mptcp@lists.linux.dev>; Wed, 03 Jun 2026 00:27:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780471627; x=1781076427;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :to:from:subject:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rKk0RBgnQ6QXPdgrmLsS0YtUrEoiTVTsgf6dX3VDE9o=;
        b=Ptf/dAQ5LHntNWsAytcIX8vqO+vsl1aidcf/Gjn/1j6X/5bcM2uqAPrOarLoloRzDw
         9ihThRh54Nrs6IslLCqYcbwpM0exqJDCyzCkxjLyyOeamsQrMQ6z+ujM5enQD2hatcsI
         T2JCW7bxDj9A3FRAsMf7D4AWA95qmlF7CA6zDiZ5A57Xr2E43zV17MlL0kIZIAZFI04v
         MsNiUpGt5sd0lgUhYKJKrij/GOh/UrCu3PY7NtPUaPiEhwGn06ZFPftosSD9AZauLsXF
         nSZoLUJ2d7DSJneV7LpyEzzORUNfDka/eg5hidnKb20dgoXPZfNMucDOfyKIiXhlEYI4
         uXLw==
X-Forwarded-Encrypted: i=1; AFNElJ+I7dd1qx5bEFT/AX8bhGxxSos8AqZA3mfQ0Y0nPl64Vzw2qvetcZiiaz9nYBFJXHh8Hz+gWg==@lists.linux.dev
X-Gm-Message-State: AOJu0YyCd2fjCy8EOgLlh0MsWMP3vgi0BsjWT86EoiilD9voXQbwR/il
	x+FOcsHizbWv6DqPyNiIK+2GPhODAOrBrnJgG6W+pSJv5p6d8xcZSfBfE38wQMxYiTQuIawWO06
	D30zF9H+LxJu4F5fHnYA1XmJ12/BwQYAPlYXTEI7sgwuq1hNZzoi86gRO1GOR+yQw
X-Gm-Gg: Acq92OGB1dFb74TtzIFXcuiWPdMQ/aotbIuR/lGV/IXp3jYSKbh7wHtHvdLkK8p7vxU
	ShcH22p7IpIZr3Skbxq4zHmhpBMQvHDui4uFnsXMbY1GFPOvdrBU9VoYb6lQTut+0TLRupshzJK
	Tzq3n9t2tHAN5qSwdO5VnBJ/ifdwU9K6P4k+iSL2MZuHN5pkRQjOpi06duWkKYsKk5dmU2fVvb9
	NnqGGi+ehJ+7MpJLhKE09FeeOwmyQeRqOHwgVsvbt8uB8KjHsIf6qz1S9CHBYEabSeCA5jGGcaC
	Qk2ytsD/+aPpxegxi3X3f/cdGf8xe2YeqzCT/jiEYywd7IuSm7R8OLWvHYUTOCAxV8kn88N9aIQ
	2s6SfQLJoPvqYMjbn2UYABnQc3xg3nyLwLocHnKUniOa/y1gPQnfRKLCRfO/nzcnhI5I=
X-Received: by 2002:a05:600c:3b98:b0:490:b11e:e4be with SMTP id 5b1f17b1804b1-490b611105bmr29414615e9.3.1780471627302;
        Wed, 03 Jun 2026 00:27:07 -0700 (PDT)
X-Received: by 2002:a05:600c:3b98:b0:490:b11e:e4be with SMTP id 5b1f17b1804b1-490b611105bmr29414335e9.3.1780471626839;
        Wed, 03 Jun 2026 00:27:06 -0700 (PDT)
Received: from [192.168.88.32] ([150.228.25.106])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490b0e88fdesm127868755e9.14.2026.06.03.00.27.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Jun 2026 00:27:06 -0700 (PDT)
Message-ID: <1d5cc4f8-399f-451b-a92a-02834408d11c@redhat.com>
Date: Wed, 3 Jun 2026 09:27:05 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH mptcp-next] Squash-to: "mptcp: implemented OoO queue
 pruning"
From: Paolo Abeni <pabeni@redhat.com>
To: Matthieu Baerts <matttbe@kernel.org>, mptcp@lists.linux.dev
References: <406ff2a2ec71581f6ea6e7882a8ea631c20e23c7.1780153732.git.pabeni@redhat.com>
 <94176982-9a7c-472e-9328-3e95fc586e73@kernel.org>
 <c6d3caeb-ebfe-4acf-9482-41f7309a86a8@redhat.com>
In-Reply-To: <c6d3caeb-ebfe-4acf-9482-41f7309a86a8@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: UycMUaix6S4QjBZm7bgN3o0YxRYxpJs78G00pn4tqAc_1780471627
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 6/3/26 9:14 AM, Paolo Abeni wrote:
> On 6/2/26 1:21 PM, Matthieu Baerts wrote:
>> On 31/05/2026 01:08, Paolo Abeni wrote:
>>> Sashiko noted that mptcp_prune_ofo_queue() is 1 byte too restrictive with
>>> the bound check compared to the pre-existing code.
>>
>> The CI is reporting that mptcp_connect.sh is now flaky:
>>
>>  - normal:
>> https://github.com/multipath-tcp/mptcp_net-next/actions/runs/26704613812/attempts/1#summary-78703396420
>>
>>   - debug:
>> https://github.com/multipath-tcp/mptcp_net-next/actions/runs/26706355990/attempts/1#summary-78708269694
>>
>> When it happens, MPTcpExtRcvPruned is not 0.
>>
>> I can reproduce the issue locally (~5% of the time), so I started a
>> quick bisect running mptcp_connect.sh, but only MPTFO and disconnect
>> subtests, in a loop, 25 times (maybe that was not enough). Apparently,
>> the issue seems to come from:
>>
>>   mptcp: implemented OoO queue pruning
> 
> Of course :(
> 
>> I didn't check the intermediate versions without the squash-to patches,
>> but I can run more tests if that helps. Do you have a rough idea what
>> can cause this?
> 
> Pruning drops OoO packets and relies on good mptcp-level retrans to make
> forward progresses. In the to samples above I see quite a lot of
> NoDSSInWindow events - presumably happening _after_ the prune event.
> 
> My wild guess is that MPTCP-level is not yet good enough/trip into some
> corner cases. Possibly paired with pruning being too aggressive.
> 
> I'll try to investigate this.

I dashed the above reply before actually looking at the PW status. 
`mptcp: implemented OoO queue pruning` relies on 
`mptcp: let the retrans scheduler do its job.`.

The latter is still rightfully on PW, and sashiko has a comment on it.

The (incremental) fix for sashiko comment should be, I'll test that and send
a v12 (or you could apply it :).

/P

---
diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 2e62fdc2af3e..a4f7e99b30db 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -2927,8 +2927,7 @@ static void __mptcp_retrans(struct sock *sk)
 		 * the current dfrag, if so try to start again from RTX head.
 		 */
 		mptcp_data_lock(sk);
-		already_retrans = !dfrag->already_sent ||
-				  !before64(msk->snd_una, dfrag->data_seq +
+		already_retrans = !before64(msk->snd_una, dfrag->data_seq +
 					    dfrag->already_sent);
 		put_page(dfrag->page);
 		if (already_retrans) {

