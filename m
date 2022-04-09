Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4B0C622
	for <mptcp@lists.linux.dev>; Sat,  9 Apr 2022 01:50:39 +0000 (UTC)
Received: by mail-qt1-f172.google.com with SMTP id z15so2847763qtj.13
        for <mptcp@lists.linux.dev>; Fri, 08 Apr 2022 18:50:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:reply-to:in-reply-to:references:subject:message-id
         :content-transfer-encoding:date:mime-version;
        bh=3uLVgsbidP+aFDzBAahgEdhHPcOB4AQ04aFxzEszPRg=;
        b=SVqUsTMikMh5nrKJh1yxGWRnUAZNysQlr2VweyFiAeyylSaWDdgCd4+yCEF0B1pNID
         uNTXqDjBr+RizC12pLjptsBc95E367e924pJt7uCP+wlGDnZAyzAe7pUc/u6rBSnEoJe
         8O7cPWZJJEhuXUxAc6M9BQbP9qnRwx6kU+iP3KANSWl6KS46mtYKVWgXwo/ioUJwb+ys
         AYiqKCxSjbuvtJSEhbvbPKFuDORiZOMohbWEfG8F6gPlsf4vLpgXVT2qutp0wIhYLVqY
         CGTj75+AY6lbQIpB2Vw3voB3k4obiUdzrMv1MuU8XWEYUoR5WEyn2/G7mEMVfjAIVH0E
         CKkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:reply-to:in-reply-to:references
         :subject:message-id:content-transfer-encoding:date:mime-version;
        bh=3uLVgsbidP+aFDzBAahgEdhHPcOB4AQ04aFxzEszPRg=;
        b=RlarrEfnD6XssgFARp5EoGncnkA1oce2tkfuovA7urXyeh9eiTLyNbnvf+rXE1EzYn
         8S+jIeaqlVvWHE2OXDPCuFGm5GFnw7C3v4VmMRZIBij3awJAfuJyrE6jCuiptiN1ZVNP
         3pP6eJhujZs2h6BB2usswLujs4VpTAgtO+x5AdnbIFyNHpoSIDrXacDBAaejE4TTuFSn
         eUoQXCulcQ7M5F31DqX+lViIyr5A9fEDENcvU3UBIi+BLgBuDhUXg3X73bmzC3QybGpm
         7fZ658DwJTdzPZAXzZeL6YN8tLZJ7hCyoqxOAUdo61rQpSAsrOT4rK5RRLD2X74f26s2
         ifHA==
X-Gm-Message-State: AOAM532rLCoMfJOUazySbPQsCEKkZjDLzk+51WtZsRzFIIaOtuWb4h6V
	AdimPTfdaHeD1KIce2Aplg==
X-Google-Smtp-Source: ABdhPJyubAfxURJAKHyJksRx0gGGtC6/If5cu5j87K1LStFz9JgEzzbJHmoTTkYLHGtketygeFCiVg==
X-Received: by 2002:ac8:764a:0:b0:2e1:bb5e:5ff3 with SMTP id i10-20020ac8764a000000b002e1bb5e5ff3mr18416854qtr.255.1649469038849;
        Fri, 08 Apr 2022 18:50:38 -0700 (PDT)
Received: from [127.0.0.1] ([20.122.8.168])
        by smtp.gmail.com with ESMTPSA id j1-20020a05620a410100b0067ec5ecac66sm16258427qko.19.2022.04.08.18.50.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Apr 2022 18:50:38 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Kishen Maloor <kishen.maloor@intel.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <20220409013825.1877395-15-kishen.maloor@intel.com>
References: <20220409013825.1877395-15-kishen.maloor@intel.com>
Subject: Re: selftests: mptcp: functional tests for the userspace PM type:
 Build Failure
Message-ID: <33aedd99-cac1-3e09-c631-8ed3c4931494@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Sat, 09 Apr 2022 01:50:38 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Kishen,

Thank you for your modifications, that's great!

But sadly, our CI spotted some issues with it when trying to build it.

You can find more details there:

  https://patchwork.kernel.=
org/project/mptcp/patch/20220409013825.1877395-15-kishen.maloor@intel.com/
  https://github.com/multipath-tcp/mptcp_net-next/actions/runs/2139046711

Status: failure
Initiator: MPTCPimporter
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/a726917f504f

Feel free to reply to this email if you cannot access logs, if you need
some support to fix the error, if this doesn't seem to be caused by your
modifications or if the error is a false positive one.

Cheers,
MPTCP GH Action bot
Bot operated by Matthieu Baerts =
(Tessares)
