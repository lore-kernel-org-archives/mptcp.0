Received: from mail-dl1-f67.google.com (mail-dl1-f67.google.com [74.125.82.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D1D3363C56
	for <mptcp@lists.linux.dev>; Tue, 13 Jan 2026 06:51:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768287091; cv=none; b=Zsy8PpYl/iCT9uFBT8U0jlQ7V8+P72coR+dzkKsuC9NzKQjNB5cFYQUTykGbHmStMtmuugFqfvlaetull8HAjHZh0Yd6wZ/ifV/c37A50xm1cRlGjQjx7cJnRjII23VBi3OqXRa/zRc1dDla+qlFgdxHaiXPgvw63aXe6s5X/3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768287091; c=relaxed/simple;
	bh=fDk7gL3fKD3tJwSbbtGylgiCI8oOPNerpqOCu3N1CYA=;
	h=Content-Type:From:To:Cc:In-Reply-To:References:Subject:Message-ID:
	 Date:MIME-Version; b=N2B4Xzfe6jvQ7NF2CVxHHRTEYI1m7RqUxLdqHH3sRJJsIR2lvnfJDfYTpfwDNm74tMGy3Hk+QwNIEly0v7gvQflo743C/08O/PeyijAcqhU2o0x2pwhXz0AnBXqF44SNHz8K6tKks0K42zROmoIm/hAYv2+Va2UY9WT0j36qmeg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AqFCcIK+; arc=none smtp.client-ip=74.125.82.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AqFCcIK+"
Received: by mail-dl1-f67.google.com with SMTP id a92af1059eb24-1220154725fso2973940c88.0
        for <mptcp@lists.linux.dev>; Mon, 12 Jan 2026 22:51:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768287089; x=1768891889; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SHoZN2by/m5d3xvBWKIZ3+K7nsaZZ762nurvVv9IVOw=;
        b=AqFCcIK+PBDvjVt9GuNvSL2s+o604r3rdJmMQoSiz4AER8C7foJk7NX6AIzIqzYGCp
         0RmScEhGOZQR5DyKSrMKeckjRWHvfOP4XneGS9lXt8Gv/RFmz8/fYFiQZc1co9OY8eZ4
         MNq1BkIL+gMGEWAtNY3zK5lF0pURVSnW9syYDJYl/eLxKw7phQJ5LzohiR+H4Fca0Lsz
         KdTFXOSl36o458LmHvg5b7yu+2BmebhxAPfp6faCrYPicrjxq0lbJl/3STmpUyRGmhKs
         RzcyZ8OxzpXN9ANh0DSWOdvENS5PpDHLwDM4esQ487WMjfvL4QqO0fhVYNnOxDzMQAh5
         +Mog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768287089; x=1768891889;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SHoZN2by/m5d3xvBWKIZ3+K7nsaZZ762nurvVv9IVOw=;
        b=pS98XpDhDVGHlGS4I+fU/gBefa5SqgJ9bhfFxl8UBKOKwhbrMgKHbdDp313/vNY8je
         lnor4LsXr81GrD5BbYuoFWEpidplJZVmofBvYfix5YluZE74aQXr9a3GWRNglUEUZ0FT
         w99h4wbQA/ra2G/CgOz4HV76TQm8yg17YRFCdm+q1vMBdbKjxOm4t7yyiI602rR1iY4a
         pqRysosQKHI+LJsXX8c05RjgDRr3w27g4HH1F2SZgLzYD4e398Y4aVT61sQDgVwsDD+h
         PstVu80jtm4eXdFI7HvBrMMyNkQbWqr7Qsx7CfJXX1P5dmM8QQPw2L2pr0fsi5KEjXxF
         0yhw==
X-Gm-Message-State: AOJu0YwpBpgJpo6z4ca0+Y8j+W09Fqj9CV0qPr2Mnp2k56nQdDQ3PdLq
	Y2yPpOymufUI3Fm/jcu5fDFxsuIAGouZn3mpTTz9qPJCRbb/RkCgb73zCyWozgo=
X-Gm-Gg: AY/fxX6H7CuoT1GPBYzqwTCslMZVki9nasoobvbxrHMW6t2pMAUJvV2hoMXIdg94sha
	j2vilLfT4bySy7LkTy/a+r/tksvekx44LWe5DTgjjo65k2RVb+yTCAvZAd5tSASYfiDPsq9TZsW
	4DMrzO9R8W6PI3eHfuF9IYWndenNh/ed4S26ALYhN5hovQId3DH8YjJJ1Pl7HaI/qGN4DmmTOpc
	e9Dq+kXfaTCTOS3qSGlbW8gwQs9ckCeOoBngu0zXLj7N8m4wJOlu7C97Fg2Fvr/i5QFt4iaSs4v
	34k43P2ySZmiFpuEhp8ZRV3TcapO1bBiXwcd0r5lFsm8pzuI0b39lTasUgwRnD06bvCsib/ud+i
	ZKf0FLHBgLESNdzYwFn9psrOgq2rq9NWNI0qFH6vVDUsFXrOmc+i/8U3J0FMyRysr47SnbBZgcA
	H9Etg6+3wp0486XpOXM8Q2o4bk
X-Received: by 2002:a05:7022:6621:b0:119:e569:f84d with SMTP id a92af1059eb24-1232b58ed15mr1974853c88.4.1768287089255;
        Mon, 12 Jan 2026 22:51:29 -0800 (PST)
Received: from [127.0.0.1] ([52.159.247.164])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-121f248c239sm22302413c88.9.2026.01.12.22.51.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jan 2026 22:51:28 -0800 (PST)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <tanggeliang@kylinos.cn>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <cover.1768284047.git.tanggeliang@kylinos.cn>
References: <cover.1768284047.git.tanggeliang@kylinos.cn>
Subject: Re: [RFC mptcp-next v7 0/9] MPTCP KTLS support
Message-ID: <d3cce2c9-7cc7-8610-7717-8c955a6b5cce@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Tue, 13 Jan 2026 06:51:28 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Geliang,

Thank you for your modifications, that's great!

But sadly, our CI spotted some issues with it when trying to build it.

You can find more details there:

  https://github.com/multipath-tcp/mptcp_=
net-next/actions/runs/20947288022

Status: failure
Initiator: Patchew =
Applier
Commits: https://github.com/multipath-tcp/mptcp_net-next/commits/1b=
5bc620d3a6
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?=
series=3D1041572

Feel free to reply to this email if you cannot access =
logs, if you need
some support to fix the error, if this doesn't seem to be=
 caused by your
modifications or if the error is a false positive one.

Cheers,
MPTCP GH Action bot
Bot operated by Matthieu Baerts (NGI0 =
Core)
