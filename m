Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E6A4363
	for <mptcp@lists.linux.dev>; Wed, 14 Jun 2023 03:01:36 +0000 (UTC)
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-62fd844ad58so3012716d6.2
        for <mptcp@lists.linux.dev>; Tue, 13 Jun 2023 20:01:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686711695; x=1689303695;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UnQXn1Peighg8PsfRtY8KT0Gbb1cHzGU5Q54UXk2I1g=;
        b=UGsGMeO3BzkNuKnWv0Kh3tBBsIgu8Cs4Ygimdm33JKiMkmc1BR8aOPmLtOPb8rA+xa
         LxNWpCftOUoIkKagsmPbqGXneQTjCyXgAsmsoRWdbLIkpUcB5WgM3iWgAWaf06RqXMf/
         +agquej2VQ2F5shR/9WuG8M0g7b5jIGO4XexF+8lUpoh9ZHm7a7qLiZmk843io1Rvlqi
         k64gqqDFrXPyB0bzD8C9N2vU8UcMCK17MHElbSo1upbSewCTJNmATKtpw5aDPfe/4RtZ
         sFo6UZhvJ1lPeXgb2AQL7n5YlthWTdYdG6PMxmryQCO5zv+7snFIlj3MaiK4sNUIcAxW
         TwAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686711695; x=1689303695;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=UnQXn1Peighg8PsfRtY8KT0Gbb1cHzGU5Q54UXk2I1g=;
        b=FoIAqmJS6wNFA2PT8gjy1XsOnS61SIhNiP6vBQhrcP5/NUGLSg5wyjJKyvWMiU2xZW
         vSxU8Z2/fwjnNmfPNsaVkRbyOVNvckC82+jVIK9dDntQOO8iZUekdlKXOqL4UK7WljEt
         TVF28dN3yb8DUQgKautBujsbb3kO0JYwn0q0Gk1tebKQNpa+CJew/k3Y+uwtLigx/yXo
         TLgg88radNuGKJoIAfVByvpd7zd1vf9gOa/ZMfC4ONlmg0J3rtQEXfF2V7HnmLUnYvXb
         IKXQJjiurI93kxHXkwT2HnsZmZiUoprZlMuIkBpgNmUQc3rfibb9RvlSrWWFv+qtZMxD
         gsPw==
X-Gm-Message-State: AC+VfDz0WWJmULiBLN2ytAACKwb8bXxaWKK9bmkvwRXmXLC5f/iWV5Og
	wqrvAAOc3iVxyXMUVCVr13ojYlprqzdfZGI=
X-Google-Smtp-Source: ACHHUZ51aWwd+IUpV4tvQq3nCCvlzJ/Mhao6OpLtLtcrnCXb5+XkztttdCjJT7Go15vGsC1H3Mv99A==
X-Received: by 2002:a05:6214:2021:b0:619:4232:aa87 with SMTP id 1-20020a056214202100b006194232aa87mr16367554qvf.24.1686711694975;
        Tue, 13 Jun 2023 20:01:34 -0700 (PDT)
Received: from [127.0.0.1] ([104.45.206.221])
        by smtp.gmail.com with ESMTPSA id oo13-20020a05620a530d00b0075ec8fb5c1fsm1621346qkn.97.2023.06.13.20.01.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Jun 2023 20:01:34 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <geliang.tang@suse.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <bd10b96d43aef97369c5f197ceb1085c99dd4fab.1686709116.git.geliang.tang@suse.com>
References:
 <bd10b96d43aef97369c5f197ceb1085c99dd4fab.1686709116.git.geliang.tang@suse.com>
Subject: Re: selftests/bpf: Add bpf_stale test: Build Failure
Message-ID: <3eb5a1e2-453e-2250-23da-b3132d01b380@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Wed, 14 Jun 2023 03:01:34 +0000
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
org/project/mptcp/patch/bd10b96d43aef97369c5f197ceb1085c99dd4fab.1686709116=
.git.geliang.tang@suse.com/
  https://github.com/multipath-tcp/mptcp_net-ne=
xt/actions/runs/5262461384

Status: failure
Initiator: MPTCPimporter
Commits: https://github.com/multipath-tcp/mptcp_net-next/commits/45a9e0e268=
56

Feel free to reply to this email if you cannot access logs, if you need
some support to fix the error, if this doesn't seem to be caused by your
modifications or if the error is a false positive one.

Cheers,
MPTCP GH Action bot
Bot operated by Matthieu Baerts =
(Tessares)
