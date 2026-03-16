Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7ABD03CD8B1
	for <mptcp@lists.linux.dev>; Mon, 16 Mar 2026 16:39:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773679159; cv=none; b=qHHCSsuxub3TpVlWtx1tu93wSfs0KlnPG5nCsaygCa+3o0pnDzPeQsWQXBjd+GUU+HAti0eKZ11ucLjKY2tdLjMq9+h3fHqU0WGHts5mLNGeDD1GzOYAe2jwq/9Syzyd33Ih9z6pzp5tDC27tkiAny2LzJ2ylMcamAoFoJu/PgI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773679159; c=relaxed/simple;
	bh=ISC1/Jh54d+ohhihvSYDEPtSjfdOLOrb+J0C63v34eQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:Cc:
	 In-Reply-To:Content-Type; b=K2bqivSMrHWJd777GgSi3E3BXjUyoxO/uVbPli8HpPEGhraDkCZtXHr4nCB6aiAT1QR3+dsTfpFoM1ZadJAIhnzU2uhf1NzPlCSpksrUfQZOMkeEiPqThB9eN8bu8iPWFNpry5c0kkCMXyz0MBNNOkCgIveQPWmtFCw3zoh6x/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XaCw2pEH; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XaCw2pEH"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1773679155;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ISC1/Jh54d+ohhihvSYDEPtSjfdOLOrb+J0C63v34eQ=;
	b=XaCw2pEHtecZe3D1G61DZ3RPvBe/ipSo7UHHNDtepyJpO/C4lX7HOlJKzemW1piMXBJcil
	6/kQxNoHRol85sRf+Gul2xSThbaBiWYlbWA+2Wk60IsTo7sr1AS/MUuJakrCD9GYBKbf4u
	vkeRlFS5GPjzERsmJWzohMj0B46Rtdc=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-164-bw_602tONs2xUuV_wBDFjw-1; Mon, 16 Mar 2026 12:39:13 -0400
X-MC-Unique: bw_602tONs2xUuV_wBDFjw-1
X-Mimecast-MFC-AGG-ID: bw_602tONs2xUuV_wBDFjw_1773679152
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-48531e6012bso50288405e9.1
        for <mptcp@lists.linux.dev>; Mon, 16 Mar 2026 09:39:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773679152; x=1774283952;
        h=content-transfer-encoding:in-reply-to:cc:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ISC1/Jh54d+ohhihvSYDEPtSjfdOLOrb+J0C63v34eQ=;
        b=A9Iqmz7grvRO3TxwahWimjbsfABo/n/KoXOpfbVSApc0FO9Kzg1bg5BII8OCsj/DCu
         InboYlRWW2GQejBdYIN8r+tSi3kAfchWCNv73XsGni7r36B6jkqokIC/Pi6uJEsMPYX7
         atJTAABrPXbU0i/mfhToF0Z2na8iXZVIeYY1ovYec0xvYlAF+RJXGEQRQbEZ+z3Vd0Wn
         ceOFCq3iHCHLXtGKMG7p9BDIPCrxEpGmU5v8iNxzRkEfCqrE+r8P5c3wzv2so4iE9m3w
         lpt6f/Rq9QmNPlHH0pGy5iLYqhqEjf3OH9zTsRsHa64GdZDt4gtSCsW/7NG2LlI1VcQg
         Oy3g==
X-Gm-Message-State: AOJu0YzIcQOALALFcKpoGTfLrtkLxsEV+UzawSXO3I0g8NhP9dcMVhgA
	mD6Rsc8+m0EQTvsCo2q5sgDT4G+I1dihnqJHwWhFzqP8hihRjsEeSVPbO2nEcN3ofHEZqYDm/b7
	0CNKTXtO3vnkNkelbp8btfcIl+aPDTyBrc/ef61417We4l2mT7e9dxPi5
X-Gm-Gg: ATEYQzxBp+om4DtxNEoZ52aSQoznZh5SJOeivYN/prVZKFWIO8f4IafqUU1/vOekQtX
	gdf4onir/sG7L38KZuJ9Gtznb9GengZfYSI7JBSnUtsDcMMc5zJVVULIEi53lQIFl4Yl6jAKIlW
	9sm7avsUaz0ESn3Xa8n8AS11Xhpone3zuYw+r4dy+BVFCRXslyJ+YWgSNrpQAkpq2F9YOM1bOyX
	zZ5MWQTgzFVVzzKguIz8E5Qb4jlsGB77ZxY3TTtmO5nWoRMthk3SOdMB6UicxtAHFYpiNbd4eal
	8R6mgJDc+iu0MGXo7qV4thq0s6Q17rImFteNMPqJCzQS4TLyRy7f/f06i02oEsYp7Frvrg4GQcK
	R0tbCbzsSSYCMWpJJM+Zk9miTw7YHoOWlXBnm9fgWsAY9nhsz+tHk/eU=
X-Received: by 2002:a05:600c:a4a:b0:47f:f952:d207 with SMTP id 5b1f17b1804b1-485566facc8mr232465675e9.19.1773679152438;
        Mon, 16 Mar 2026 09:39:12 -0700 (PDT)
X-Received: by 2002:a05:600c:a4a:b0:47f:f952:d207 with SMTP id 5b1f17b1804b1-485566facc8mr232465135e9.19.1773679151987;
        Mon, 16 Mar 2026 09:39:11 -0700 (PDT)
Received: from [192.168.88.32] ([216.128.11.95])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43b3b0e9b99sm21050236f8f.18.2026.03.16.09.39.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Mar 2026 09:39:11 -0700 (PDT)
Message-ID: <2ae6ee59-6412-4f47-bc20-47d8df3dbefd@redhat.com>
Date: Mon, 16 Mar 2026 17:39:10 +0100
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH mptcp-net] mptcp: fix data-race in __mptcp_retrans /
 mptcp_incoming_options
To: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
References: <20260316-mptcp-data-race-snd_una-v1-1-221704522c67@kernel.org>
From: Paolo Abeni <pabeni@redhat.com>
Cc: MPTCP Linux <mptcp@lists.linux.dev>
In-Reply-To: <20260316-mptcp-data-race-snd_una-v1-1-221704522c67@kernel.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: lMGukHNHS9gaqHgbYM2NivPbyPc3Tj34QCjtrgvKFjw_1773679152
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/16/26 12:47 PM, Matthieu Baerts (NGI0) wrote:
> It looks like msk->snd_una was being modified in __mptcp_snd_una_update
> while being accessed in mptcp_rtx_head().

For future memory it could be possibly useful to specify that update is
under the mptcp data lock/msk spin lock and the reader is under the msk
socket lock - and possibly drop a comment near the fields definition.

Patch LGTM!

/P

