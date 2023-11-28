Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95AE358AD9
	for <mptcp@lists.linux.dev>; Tue, 28 Nov 2023 14:39:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YVgPoOU/"
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-77bc5d8490dso322764085a.2
        for <mptcp@lists.linux.dev>; Tue, 28 Nov 2023 06:39:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701182351; x=1701787151; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Aiw8xePiLNMnnXZkNs1EiCD/sqyGBbTrhUEwTJWbZd8=;
        b=YVgPoOU/KiYp/JqjNZVyME9cp2bWzblruqeI8xCs03wQ6eAO5nbBU2Afsv1C9Id0tO
         Ek7C5JcjyQZN2qUsqE+4sOzKQ+7VN9LCKaHBd/gXLdF2vj9v3/slUcQHJzKACpuNuW+P
         I0W+SEHOqwdBGay3IChKve39H6xaISl2z7xcUxULF+Bs+LXDTL2kaksdTMj4warKqMLF
         8XcOcIOQO89zXr3tCzvK5h0bAHUiuLhP6LxUJ3M2Rpe+kVvJjwOd/oghbaaneeTu4dvu
         mpdW9hPA6tfSvytsoPdOyhWEqaeLgGV2MWgiM0dORlVvT68OYWx6h753MWA2zenEIyM9
         udXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701182351; x=1701787151;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Aiw8xePiLNMnnXZkNs1EiCD/sqyGBbTrhUEwTJWbZd8=;
        b=YXUQvNkIBNQCJNp2Ziacoo0uF8Ltzlt8cD8WD0f6D9hPXCRBwWb8/7O3hm30GyddvV
         jJWVfWVdcE+7eR6T4Xko7Eruwlpa+6mi9pruN1yvZ4ajqFDjMYgL4aBowiuFB+HUHIP8
         jmRWYinQKK46HcR/zwUXRxXctFjJfrvjbKQxhqdwyGSqeM0x2Shx4MFl1D5fsl5AvGAv
         hhFSeGDe4DKZZVprm4suXHGmMX2kObDA/avQ+20C8XdFKHWQQ/BoJ29Pu7hIHf5/MtpA
         ZA3osjuZRY0h575hk977Z3Tplc5mFlW67o8DANMBNfBkvcxHelXejs+dYUylXinn1sur
         fXlg==
X-Gm-Message-State: AOJu0YzOk7ovCtKJN5aXN9wykx7K9jGIV6yb98kdCetsKaNEHXdjV39D
	uyFVTVbRyrPVn336MTloVLyfHcC7K8XO
X-Google-Smtp-Source: AGHT+IHkpxVawfMF4yQUbh83jnSqy1UImhSrk8h0cPotuLvLbqLmAJD+37AlZBL1WdgKuNCdSy7ffA==
X-Received: by 2002:a05:620a:4382:b0:77d:5f48:9e7 with SMTP id a2-20020a05620a438200b0077d5f4809e7mr17071285qkp.74.1701182349073;
        Tue, 28 Nov 2023 06:39:09 -0800 (PST)
Received: from [127.0.0.1] ([20.55.15.20])
        by smtp.gmail.com with ESMTPSA id tx10-20020a05620a3f0a00b0076f1d8b1c2dsm4525672qkn.12.2023.11.28.06.39.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Nov 2023 06:39:08 -0800 (PST)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <geliang.tang@suse.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <0b59f639265bcd844b1d51597ffd5e172127732a.1701180777.git.geliang.tang@suse.com>
References:
 <0b59f639265bcd844b1d51597ffd5e172127732a.1701180777.git.geliang.tang@suse.com>
Subject: Re: selftests: mptcp: join: check CURRESTAB counters: Build
 Failure
Message-ID: <7daa24c3-b562-9e81-0531-98b393b0d112@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Tue, 28 Nov 2023 14:39:08 +0000
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
org/project/mptcp/patch/0b59f639265bcd844b1d51597ffd5e172127732a.1701180777=
.git.geliang.tang@suse.com/
  https://github.com/multipath-tcp/mptcp_net-ne=
xt/actions/runs/7020263867

Status: failure
Initiator: MPTCPimporter
Commits: https://github.com/multipath-tcp/mptcp_net-next/commits/9fc088de65=
72

Feel free to reply to this email if you cannot access logs, if you need
some support to fix the error, if this doesn't seem to be caused by your
modifications or if the error is a false positive one.

Cheers,
MPTCP GH Action bot
Bot operated by Matthieu Baerts (NGI0 =
Core)
