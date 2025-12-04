Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37CBF274FC1
	for <mptcp@lists.linux.dev>; Thu,  4 Dec 2025 08:37:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764837461; cv=none; b=NzWk+VOJ4qK4IHw63sr+FHYH818kHVhnDtX4QbAPz/Fo7L9lEPVC/r94Khpb/u7Id18cy2Z5+fxk6pznIP217iTzyZolJ7PglZkCRrTTqdt53XR1WNU3np1cBQ5WP2EF9SRRWWT9UaxmxLrHzTGO5gbNBSxWeiznNLJz8G9gxW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764837461; c=relaxed/simple;
	bh=Fgti3Yp68+r1SXdHjNvigqNpTieQfP3rIFRvqwDgXVI=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Cc:Content-Type; b=ObkTvFBIKSi9fY7YJpM+Cf7mXxiNkngaRTDpSCC9Ffxzpd8E5xm9r5HLBfSOvcKsiMEn/+oREsroYc7Gx15/1Ac/qyRq4Dv4f9mu7eojsocz6a5S9GgbqSJBqfnhJo2JV8aDXowChDr2noiwfrjFWaHwLjORY3uobbiXqIDDHbw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZpQFNzAe; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZpQFNzAe"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1764837459;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=Fgti3Yp68+r1SXdHjNvigqNpTieQfP3rIFRvqwDgXVI=;
	b=ZpQFNzAeVEUSBeymrYARs3asayHbvEII9+G4r1uEZnc5FW5fYhOlaaaD2RvhNLax/Ehy5N
	SvtePppkfmYVgR6tlFfKd5RY+oXhriCS1xsXBqU3Mkk/QI8AHj+CkdBc0+XS+HBg2P8Z3s
	Zhrpe81G2pg6o4BjZekHMXC/0jkzWtI=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-633-Z_G2Y6p_O7uCs_KWBHqs5Q-1; Thu, 04 Dec 2025 03:37:37 -0500
X-MC-Unique: Z_G2Y6p_O7uCs_KWBHqs5Q-1
X-Mimecast-MFC-AGG-ID: Z_G2Y6p_O7uCs_KWBHqs5Q_1764837456
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-42b56125e77so296209f8f.3
        for <mptcp@lists.linux.dev>; Thu, 04 Dec 2025 00:37:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764837456; x=1765442256;
        h=content-transfer-encoding:cc:subject:from:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Fgti3Yp68+r1SXdHjNvigqNpTieQfP3rIFRvqwDgXVI=;
        b=Ec+ePdpgcZpTd0/zQz7bjGKx531rAkMOZE++vgScEjexPKh+22+t47qzOYlRz8wau+
         e6t+hShEXwXBCjDTy681CnhJ19zD6d8WuMs21rQktMuOg/fYH+NT75/SO4jBtgR7RCuH
         mVKwN5C56wG+sRLjhNIYPGKaAMNrK9pvUt8fCDlC09fVRCbdtd1d0Y7MA6BBkLcHvySN
         q3ieoX2dlgwG94/+MzmL3n3X5tW2w6hU2/1p5qLOPCyxv8juVutiGIM3pxLtVqsMkG0k
         RBb4QP/OJwVn2Og3pwA5mvoLK2MLCRGTO/8GC9K0x8Cu11JIvh8fMKmGV2xjHyzP0iXH
         kmkQ==
X-Forwarded-Encrypted: i=1; AJvYcCX9kQmA8w+H7ZH2p8q4o9Qn2jnXYzTm+qbCUX6mwAruAZ+6m1YS7Pd70UfKS1XV1kxt+QE+eA==@lists.linux.dev
X-Gm-Message-State: AOJu0YwWJV+bE4olMID94w6jMFyb9gKNql8MXunlRHb+9hNsTuLbyH+m
	eCdMtpMUBgIoSs5A1/wm4TEq+aw+AVkcqNrhQF6ANsHyrTLvsPr2ePmQFpFTkODiLay/dTAEfuy
	bhlQZ04nmlHqNWpDf83kuaLyMv5SEV5fRfBPkk51HYxpVL9QtoHncpOj9
X-Gm-Gg: ASbGncub8refLFMiLCaNch4ENH6Yk3bBSSTmJqGJ4Wf002u1m01rZpjmzfYaym6p25r
	LVFjgt4ah5HIfxN2DboVUs+5bEOO+OL7m6p3TyZQz1nKwS5p5ydF4xqpvNtODO+pF5lsDVlTNSM
	qjdPI+tKzsdOremlKAp1jp2PbwiehnuzGmdBDYe2rVhTpXncXAnpPpKrS0ATm4W5NhSy10olKAn
	SvkEeryFEJux8TH88y+Wn9KIrlPkzHnC3BRUb2WEXGvRNoNvY3lB/1j0lBk6Hohs9x0NH7p8eCF
	+UVcyz3VQW7IN4L/Vf8O8n2clYzjiZwauxCGzW7HZG4yNczfWh0ABXHWUJURwxfWdTbQZhQIISg
	lARqI/04HU3eL
X-Received: by 2002:a05:600c:3b1f:b0:477:fcb:226b with SMTP id 5b1f17b1804b1-4792f24413emr20683915e9.2.1764837456393;
        Thu, 04 Dec 2025 00:37:36 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFOFiaycmUpSi4NFw0Dx9Owuk3m9GKbQxWbEzhOFEEvLDFewzTh2sfwX63tPD9WFtnBq5V4Cw==
X-Received: by 2002:a05:600c:3b1f:b0:477:fcb:226b with SMTP id 5b1f17b1804b1-4792f24413emr20683335e9.2.1764837455818;
        Thu, 04 Dec 2025 00:37:35 -0800 (PST)
Received: from [192.168.88.32] ([212.105.153.24])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42f7d352a52sm1925339f8f.38.2025.12.04.00.37.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Dec 2025 00:37:35 -0800 (PST)
Message-ID: <3a2cf402-cba2-49d1-a87e-a4d3f35107d0@redhat.com>
Date: Thu, 4 Dec 2025 09:37:32 +0100
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: "netdev@vger.kernel.org" <netdev@vger.kernel.org>
From: Paolo Abeni <pabeni@redhat.com>
Subject: [ANN] poll on EoY break
Cc: Johannes Berg <johannes@sipsolutions.net>,
 Pablo Neira Ayuso <pablo@netfilter.org>,
 Jozsef Kadlecsik <kadlec@netfilter.org>, Florian Westphal <fw@strlen.de>,
 Marcel Holtmann <marcel@holtmann.org>,
 Johan Hedberg <johan.hedberg@gmail.com>,
 Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
 linux-bluetooth@vger.kernel.org,
 "netfilter-devel@vger.kernel.org" <netfilter-devel@vger.kernel.org>,
 Oliver Hartkopp <socketcan@hartkopp.net>,
 Marc Kleine-Budde <mkl@pengutronix.de>, linux-can@vger.kernel.org,
 Dust Li <dust.li@linux.alibaba.com>, Sidraya Jayagond
 <sidraya@linux.ibm.com>, Wenjia Zhang <wenjia@linux.ibm.com>,
 "D. Wythe" <alibuda@linux.alibaba.com>, Matthieu Baerts
 <matttbe@kernel.org>, Mat Martineau <martineau@kernel.org>,
 MPTCP Linux <mptcp@lists.linux.dev>,
 "open list:BPF [NETWORKING] (tcx & tc BPF, sock_addr)"
 <bpf@vger.kernel.org>, Magnus Karlsson <magnus.karlsson@intel.com>,
 Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
 "Jason A. Donenfeld" <Jason@zx2c4.com>, wireguard@lists.zx2c4.com,
 Tony Nguyen <anthony.l.nguyen@intel.com>, Tariq Toukan <tariqt@nvidia.com>,
 Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>,
 Heiner Kallweit <hkallweit1@gmail.com>, Russell King
 <linux@armlinux.org.uk>, Aaron Conole <aconole@redhat.com>,
 Eelco Chaudron <echaudro@redhat.com>, Ilya Maximets <i.maximets@ovn.org>,
 dev@openvswitch.org, Steffen Klassert <steffen.klassert@secunet.com>,
 Herbert Xu <herbert@gondor.apana.org.au>, devel@lists.linux-ipsec.org,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Andrii Nakryiko <andrii@kernel.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: Chb67b39Wnk5hhB3mMFvEdLkc-LUn2GEMhGm9jbq6xs_1764837456
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi all,

Due to some unfortunate calendar, conference and personal schedule
circumstances we (the netdev maintainers) are strongly considering an
end-of-year break similar to 2024'one, but for a longer period:
effectively re-opening net-next after Jan 2.

Since this comes out-of-the blue and with a very strict timing, please
express your opinion using the poll below:

http://poll-maker.com/poll5664619x19774f43-166

The poll will be open for the next 24H.

Thanks,

Paolo

