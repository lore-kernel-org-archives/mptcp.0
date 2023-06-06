Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 540EA125AB
	for <mptcp@lists.linux.dev>; Tue,  6 Jun 2023 09:35:26 +0000 (UTC)
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-75ebccc2c9bso144191185a.2
        for <mptcp@lists.linux.dev>; Tue, 06 Jun 2023 02:35:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686044125; x=1688636125;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=41HTsPj2DMU462U3kXKByiBpHl5eqcCjysL+hg9JytI=;
        b=H6qQsdH3I2YvdtNmMWYpeR8OOXczuBYtM0Znuns/GUUrIhNF+Xa5fyv/FHw/M3q+62
         /hwXnPHFhNgFjQDlkKM6FwEPSSorwzLe43XquNrYRfdauG6ZyQqDoURPSbP88ZppHV0O
         F/s1P3KLvhxrP/dx7Yvapk2797ibwYy52StTjPHGO0S+YYdarkyTlKuowHHS0+hnhpWH
         8xD8cYmffhx3tSxxBbg2MMohdI6p5CaBVnzCAAr/Q8sGry0glBgKP/KOysOYgg8SL9jA
         JiVniSEChof6WrPMNEwXsbfxTjYXbxsGkFNBHLdUIqkp4EXFQ/8Wn4dNM8qTZvR8WhvB
         7Kxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686044125; x=1688636125;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=41HTsPj2DMU462U3kXKByiBpHl5eqcCjysL+hg9JytI=;
        b=YqVF0y7WJ6gF2VkJA+8P8G7dlHYnrfzg1nXaGxbxyjzHpTCA71XfGOO/IzDwx4O+QB
         kDi8Kb4YgBkCXq4L2khNlqNksgwLjt4m6vrqFUV/g9QgB1pVqXVYGZIaAOZe0K/iGpps
         Bt/dVORkro87hMU+GnsbQ/eWrLJTtanqc3pwr9Kj8ecvsHn7VlyJjBqdk40o8oBxNVVB
         +Dsar432DrUOK0+fUUJB285Muk6BBq7VvCAVmpstZpOkKIobHIm3ZU8EoklZIXq1Xmlf
         XQuodXp/Yf+tNZMImB1Er7xz2HZqbKntPcZ1C9UhjirlmWqmkVyKM6FHEfkMlWsQ69N5
         LvqA==
X-Gm-Message-State: AC+VfDzhMJuqT3A8qpnC6WwcciQo6Pi7ESM4WwUB36naCRl7yVyv9D/c
	WGEAvbWFNk6DBJmlBL0yjg==
X-Google-Smtp-Source: ACHHUZ6xH03jJOnIu+ek3mKu1/Y50NOwoKhkt+MfR2ffGvPUnDiEy/TR/gSzNaWOWL624GGWRbBPyw==
X-Received: by 2002:a05:620a:4496:b0:75e:680f:856d with SMTP id x22-20020a05620a449600b0075e680f856dmr1722399qkp.18.1686044124980;
        Tue, 06 Jun 2023 02:35:24 -0700 (PDT)
Received: from [127.0.0.1] ([20.49.36.17])
        by smtp.gmail.com with ESMTPSA id q27-20020a05620a039b00b0075b01970aaasm259333qkm.32.2023.06.06.02.35.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Jun 2023 02:35:24 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <geliang.tang@suse.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <1cf433961986135e884dfc35b981c82ec6a5f528.1686041504.git.geliang.tang@suse.com>
References:
 <1cf433961986135e884dfc35b981c82ec6a5f528.1686041504.git.geliang.tang@suse.com>
Subject: Re: selftests/bpf: Add bpf_stale test: Build Failure
Message-ID: <0a4a574c-0caf-ad80-41eb-3dcaace3eda0@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Tue, 06 Jun 2023 09:35:24 +0000
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

  https://patchwork.kernel.=
org/project/mptcp/patch/1cf433961986135e884dfc35b981c82ec6a5f528.1686041504=
.git.geliang.tang@suse.com/
  https://github.com/multipath-tcp/mptcp_net-ne=
xt/actions/runs/5186810224

Status: failure
Initiator: MPTCPimporter
Commits: https://github.com/multipath-tcp/mptcp_net-next/commits/a49d687bcd=
1f

Feel free to reply to this email if you cannot access logs, if you need
some support to fix the error, if this doesn't seem to be caused by your
modifications or if the error is a false positive one.

Cheers,
MPTCP GH Action bot
Bot operated by Matthieu Baerts =
(Tessares)
