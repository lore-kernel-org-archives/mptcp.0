Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793519782;
	b=uPCeu9Liwq/aC2Vam7YKfBuDRVRRrTKVFSAt97SMARruuQRGrzMyFV1piseTn6RdIzv2
	 ZK5bGEF4TbayrH/HxFIy3XSBL8w7PIZCIMv2zNoWTSTPEB877wCFBvWd2rtjiJsmcY37o
	 lud+TP1YB5/LW04Bjyg7AwJVZOA76s8L5zBo15F4ZIyu6KSqm9q1MhENc5QuaYKL8huSC
	 vp10eyzI2lhXrRR+rqgn/wDD/pYkSmEjEbhUASmFbtLf3bZ7dm4AEhMmN0+yqYSPLtnhe
	 50q7VnmIpxPaAjj07ndjclM90wWIsKjnJVruxjCVVTPTFVf2JLjSddFhsQjVvP6h4vQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793519782;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=kFY9hhk29xbQdqGRwjUa/Q61p2tMbSLoVP0yOEgkhlU=;
	b=knaH0AC1i18eeTl8gOxXQ9Pd0kHw9hxziXGVkPO6Q68y/Tmuu9kX1gmKgRa3JDmQOwgd
	 oKa8quXePr+d4ZwhP9HvOMEWsvlWFA51oeeIKg+KEDmZ/j+8K17mNCxx2csEAD8ryu/Pe
	 /bATpdyp4JMgPkuOpIs+mRRcLyBPp9mxIcrxQUtnQom9TJE10AgVZn4Upt3abU1d96Jgt
	 i6iWZb7UwFXRcxU5aG+58rRiom/oaZhTg65bbyU1umC1dAE/kndhNLhH3pXhWu+5JyHeh
	 JK+qpdNB7W6c7jUPPj5t60AlqeuQrjBp0apspRgDW7xHnfjN0/3Ry6S+Fz0DJ1a77BQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=mGyfbu09;
	arc=none smtp.remote-ip=74.125.82.51
Received: from mail-dl1-f51.google.com (mail-dl1-f51.google.com [74.125.82.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48C17606A324
	for <mptcp@lists.linux.dev>; Sun,  1 Nov 2026 07:56:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 48C17606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=mGyfbu09
Received: by mail-dl1-f51.google.com with SMTP id a92af1059eb24-1438d9363fbso1515077c88.0
        for <mptcp@lists.linux.dev>; Sun, 01 Nov 2026 00:56:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793519781; x=1794124581; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=kFY9hhk29xbQdqGRwjUa/Q61p2tMbSLoVP0yOEgkhlU=;
        b=mGyfbu09ip4HuoWh4oRQy4DnAy+YeAb/spqaaVxBQnDHMeNpmJWjIDFzwce7zqO3oO
         mxZaCf09zHJsP+ydP2DThYkHLs5xSV8/O7uo0c3JmnIBokwsc1TzG2TCvBKBtXLdKLKa
         tpbnLLraCV2LKKG429V0qYTJFH48ZCjSEox/RKIItstdoz5CDIZCTDqstBvWSf2gBfed
         uTAr7araUU8A+heIb0DIhkLbgCNSlGihns5kpFboXJ64H4351J5tzcef2t07SxjyYVFB
         YLnubC0yPjOGqPHt5E7qi42P0p5HRMVJM5/m3rvc9i1ejxctX8heMUA801BstBxPRAWG
         ZRAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793519781; x=1794124581;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=kFY9hhk29xbQdqGRwjUa/Q61p2tMbSLoVP0yOEgkhlU=;
        b=L3hhRvCkCvEFtUZH7rLDiK6xctyHTDSq9g+GNbasIyiDLcgHcQLTPpwu92jIHt4ldq
         35qL5DBmKRiFKXoAIp9MdcMc7OEHV3bGckhc+Lm7gv6RvMEvfOj+c4sVl9ecygYBZusg
         YzATDlZM2sQze4zmD5OmrHmpBoZobui6pKM+FOzulTUTlFPiml9v1SxCwJOdgFQ2EvHH
         UTuxxzadN71/28ybc1cFXBxkXo/M04Oh/jI4MHG6cUfBcNVtjiYTA3+3AhWGWNAW76jm
         16ExPIWDuSmapozr9FzR6xZG1x4J0e5CGwrmctOeqdooIJaSh5eI0zqAKz3UTp3TboT/
         OGmg==
X-Gm-Message-State: AFq9FYLqKWDcBtHjjjxRGCSJ6sB98k1h7DJdsW5k37eTlEGI2wYuSSLn
	pTHZbgF94xQgIgIfhgVeyK7ouVpqrXzp7C3+ewi7EyLCE9iVp8NfpDhX
X-Gm-Gg: AYBFou16TASj5ZBa/zA0XWSEuNjPEhHID/VZMLPxFvoZW9g4y87IPU8vYowqpRDsrv6
	r5nX/awxOnvtgJzIFC/msr2ATebHZptsYlPNWRuMX1P7sp3zYKek/1jU/d3nAS5ilivVoEfnieM
	s8bIVl1Ob6XrQVbNYeD4c7GS+EB4ETYjJaqkrGeCJOB+Awh9z/ahkOnbbRNyIibpPg75YhZuHgp
	3ENUuaSWR/MBL6wAn3LwtUaLx00y7aD6GMXCfpQaKUFJxfWHhfYRkTOyab/7OcXBsILiTTZabMf
	wrTVzLk0UwVgP/dGQ04g2O9u/EDfDVEFEF31li/5vxZHQ+z/cEDo9ccbXP2oOiuQDWYQJZa27h3
	8a89calwzFWAWHTMmbt6gwt4NG5E3DSRWWHRXqbEqD/YFrD+KXYgFN2iclL8xz7Cz3wfwYmEzgc
	aOkc0autQEXzGA9qQVRwDgFfcCaYzy2FnmKyIZM2Hr22T9GW06oTzwZLgqGRei8w0sueApDSZOD
	E2m18ZzUlbARBc7K0e6vkUYLuh6V9Yn7d9A3GBYm/TGchonpqJyE15nrgxR/lmsPp/1J2UVznze
	24+aYKmGyeG686hz7i8l780d4cLY6wYG0bo0JGbrWCADGiSPme6ASEhWhmfkCbck8qSG7NW2588
	DNrqmtKAYMtbU+YLM3CAB2yz9tUNKezjii55TwqG+ZIllIOGtYgXE0X9tmRHmBfhjTCIDv1Hkng
	==
X-Received: by 2002:a05:7022:4588:b0:1a7:4c5f:57e9 with SMTP id a92af1059eb24-1a94b852aabmr19571492c88.27.1793519780920;
        Sun, 01 Nov 2026 00:56:20 -0700 (PDT)
Received: from ramen-dev-security-2.asia-south1-c.c.ramen-dev-345017.internal (90.156.200.35.bc.googleusercontent.com. [35.200.156.90])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1ac193b8179sm25581336c88.11.2026.11.01.00.56.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Nov 2026 00:56:20 -0700 (PDT)
From: Anil Kaushik <anilkaushikwireless@gmail.com>
To: Matthieu Baerts <matttbe@kernel.org>
Cc: mptcp@lists.linux.dev
Subject: Re: [PATCH mptcp-next v7 3/6] mptcp: pm: in-kernel: add the subflow-retries limit
Date: Sun,  1 Nov 2026 07:56:16 +0000
Message-Id: <20261101075616.3890901-1-anilkaushikwireless@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <56679372-0ae6-43bf-b0fa-a6b853a1b68c@kernel.org>
References: <56679372-0ae6-43bf-b0fa-a6b853a1b68c@kernel.org>
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

Hi Matt,

On 22/10/2026 10:19, Matthieu Baerts wrote:
> That's a good idea to use netlink policy to check the maximum. Do you
> mind adding a patch between the current 1 and 2 to do the same with the
> other 2 limits to uniform everything, please?
>
> Either that, or continuing to use parse_limit(), but better not to have
> a mix of the two.

Sorry, I missed this on v7. I will add a patch before the new limit
that checks the other two limits with the netlink policy too, and
drops parse_limit(), in the next version.

Anil
