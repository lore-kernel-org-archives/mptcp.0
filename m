Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CAA1339BC
	for <mptcp@lists.linux.dev>; Thu, 12 Sep 2024 10:45:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726137957; cv=none; b=JTjLLquZZt51112tXycARdbnCVvbKJji7dBHZh884a2WWfsKl5+bfx3jrxPk7S7dnEfoiWW75gk969/ojbeZG3cu9OTaPJBqBXEhLtMc2nbYs54aHbQzR+cBf7OkeGbGpc544FmyWTWosvJyws/FuoQEqYGT6kzIrwUK5CMjWSA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726137957; c=relaxed/simple;
	bh=U624MWPFav9SlVzXGX54Jggaoa7iDKlupBsQUyb+btc=;
	h=Content-Type:From:To:Cc:In-Reply-To:References:Subject:Message-ID:
	 Date:MIME-Version; b=UnG33qL5yKWE4rIP4WXaj0/KkbG0PUXdUGe6HG0/sF2n75YVzNC4CeIDNqQVlH2vKpXL5C0dVAres5xZqAOrUNVSf3Y7F2cFTw4ugCrQZwdgvd134YgpP0iFTtv2H97vSYJMlI+bDkRKgWO8JJx9wJjYb9lOOpVr9LXuagp7kUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TDbfqKCM; arc=none smtp.client-ip=209.85.222.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TDbfqKCM"
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-7a95efbaf49so82506585a.3
        for <mptcp@lists.linux.dev>; Thu, 12 Sep 2024 03:45:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726137955; x=1726742755; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YRj8lNLif8nQu0anrkfA/bF9jp94pCNpth+WYBxBabQ=;
        b=TDbfqKCMDPe5K3RsfeRk3qeEvEVjaHlZQrbaFJD8wqqq5tpZpNAMatKp1QH/ymAI24
         tsJa08YdbA5Q8pe+bWK0yKpGs7Xwlibe1+Z/UWAkNnm75J4dDqwbQFWXvGD1FMNQ8ThX
         DuRYoSxFwX+xPADEOF0zq5q3CCaimKWIa0bzDiHfW0KxOHSg3ISggFIt/R0I4XQJnrNe
         exFy9xHr6eiuOCIgU5oNQaAoKaKqCJwuE2BRPns8lMeUNUTZdaC8eJSPTndRZuv6hu7F
         KMpXSm4/TFDhFW3eK0qWa7oTYvuzSHvu/49/zJM/nyLzEh8CI1BouEwO8T6Ke2bbd0jI
         bgVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726137955; x=1726742755;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=YRj8lNLif8nQu0anrkfA/bF9jp94pCNpth+WYBxBabQ=;
        b=KGvAVkGf25HLToUb16KZpXzRI65FzO9OCKPFu+5QKsUWgahvbGjnWYXYiH+xMLsLF7
         qvJ5ANIzQl5qZE9sk5t9Tk/BZYm6BR3LDK53yMowr0huHZGhC8e39PzMAclxiwyMYCF5
         Ub3oYrfA0jT+isH1J+meziSE3h2RnhnGj81hGTC4FwuQQCK6eD/Q86NnNUwjrVb2mksE
         QVdrCB5WdUnj/cr98/2+KBGQhTLDEzrlGcQMAi8sKHqeG9px4vnsw6Xryyr8KjwQedVI
         T4s5KRhoDDuAeaz5KxU+vN6m+9Oo5cuZYoQ4+3LCJpISsMlCYq0bL5yYWb/TUx8Erdaf
         iUqA==
X-Gm-Message-State: AOJu0YzbULVJcooy+Cb1bNgPSMNFgnQtMFNuZS/kdWfP9gyF+HTCYLVv
	nzVntN44BBn+yq9HDFxW2U0IhYX7G+P4bakuXiyDJPx0/5Ri4IuofH3o
X-Google-Smtp-Source: AGHT+IGNA+Bv31tKX15Tgtv0nFnnJBtmu+TxD4cz35bjpYDbSQUIV/94OEV7b4XgV3x36aIRcmDunQ==
X-Received: by 2002:a05:620a:44c4:b0:7a9:bc9b:b5d with SMTP id af79cd13be357-7a9e5ee5524mr386402185a.11.1726137954912;
        Thu, 12 Sep 2024 03:45:54 -0700 (PDT)
Received: from [127.0.0.1] ([74.235.135.241])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7a9a794557asm522878485a.1.2024.09.12.03.45.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Sep 2024 03:45:54 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <tanggeliang@kylinos.cn>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <cover.1726132802.git.tanggeliang@kylinos.cn>
References: <cover.1726132802.git.tanggeliang@kylinos.cn>
Subject: Re: [PATCH mptcp-next v5 0/5] add mptcp_subflow bpf_iter
Message-ID: <b83074bc-4407-abea-ef13-a1e7908b3126@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Thu, 12 Sep 2024 10:45:53 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Geliang,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal: Success! =E2=9C=85
- KVM Validation: debug: =
Unstable: 1 failed test(s): mptcp_connect_mmap =F0=9F=94=B4
- KVM Validation: btf (only bpftest_all): Success! =E2=9C=85
- Task: https://github.com/multipath-tcp/mptcp_net-next/actions/runs/108283=
70091

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/8e5f73626f7f
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?series=3D889689


If there are some issues, you can reproduce them using the same =
environment as
the one used by the CI thanks to a docker image, e.g.:

    $ cd [kernel source code]
    $ docker run -v "${PWD}:${PWD}:rw" -w =
"${PWD}" --privileged --rm -it \
        --pull always =
mptcp/mptcp-upstream-virtme-docker:latest \
        auto-normal

For more details:

    https://github.com/multipath-tcp/mptcp-upstream-virt=
me-docker


Please note that despite all the efforts that have been already=
 done to have a
stable tests suite when executed on a public CI like here, =
it is possible some
reported issues are not due to your modifications. =
Still, do not hesitate to
help us improve that ;-)

Cheers,
MPTCP GH Action bot
Bot operated by Matthieu Baerts (NGI0 =
Core)
