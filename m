Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22A83258E
	for <mptcp@lists.linux.dev>; Wed, 30 Mar 2022 16:54:54 +0000 (UTC)
Received: by mail-pf1-f178.google.com with SMTP id y10so15971567pfa.7
        for <mptcp@lists.linux.dev>; Wed, 30 Mar 2022 09:54:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:reply-to:in-reply-to:references:subject:message-id
         :content-transfer-encoding:date:mime-version;
        bh=eCAv/fAZhgcOb3rNZHCCcenoMnDqsQzScbg+pKj98ow=;
        b=abYwlgofGlWk1yP5m4RSodY2S2KLoiw14bwaEkcp0G/TnZwGUd9aM+PnMxhFZyUChs
         1riyz6azGfo9i/iSgEAgayxI9PUKzX6bxYYOfUS1N5Dgii4fZwz9oSYAvfqAHCBk1NJw
         caO23VyWTvXjFmM0liL6K4Cf2apbcTCbHQhPPcaxhO2CLR7zLV2/qI9Idg6WYeUentDx
         ieusVaD3mGLezBYHbiX6xckbcW37+CSBL9xL5BOZ8m9sfXUAx3o3M7YGjpBXLZDdLW7d
         67n81Iu50/labAKE+nHXge6SeXp/80fQCB1SBEzdjPLWY/xvJpFJZSCkymO8+s3Yzcv9
         +abw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:reply-to:in-reply-to:references
         :subject:message-id:content-transfer-encoding:date:mime-version;
        bh=eCAv/fAZhgcOb3rNZHCCcenoMnDqsQzScbg+pKj98ow=;
        b=fKDvVIFpamYA52wCOwrtLEa+H/IsCDBmwaCSrzo3cSsZ4w3F6S60Po+ti+MHfQg4EQ
         qCaEMKwGVowFs6iqOzaxzwMJgyvwtEZvx2UXYs1BdUq+PQcFhmJEynf6Oee/gHhGY21e
         /VBGmtOQ4t37G8x2E2RK9ybfC5SCvrgXbriRCTr1DXl5dhYnUgpwzpCz0ptvrKlaEaro
         LWKikDIeDJ80Hgo1hirwj8w9obR2HCPcQrJxE2Zl9Ko0cWXuRW8o3EssTz9rz6m3GjWS
         +2IRekjbNgCBxFwkZRgWYOuX0Btt7Pssy2zpntztZ7c6JQz5I4zmSc8QhwBS7i6+5PFp
         Jcxg==
X-Gm-Message-State: AOAM532g9NcD3u/DGDKeRRCSaVRnlveMl9g9z7HUOX5jBGxhYMXuQ/ow
	IeW6F+9uqGLq56J37JyaNw==
X-Google-Smtp-Source: ABdhPJz9HkKd0apyPpkwzlxLN3Rtfctw8/OTEfKQSfg6EqDeAUtaQTVrLhH0h4nbIBQzKVdnCzQYrw==
X-Received: by 2002:aa7:9afc:0:b0:4fa:8750:152e with SMTP id y28-20020aa79afc000000b004fa8750152emr447944pfp.52.1648659293548;
        Wed, 30 Mar 2022 09:54:53 -0700 (PDT)
Received: from [127.0.0.1] ([13.64.119.33])
        by smtp.gmail.com with ESMTPSA id d11-20020aa7868b000000b004f768dfe93asm24154056pfo.176.2022.03.30.09.54.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Mar 2022 09:54:53 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <geliang.tang@suse.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <2d4db6f87d2a8f8be36140aa7feabc7cdea87ec1.1648223504.git.geliang.tang@suse.com>
References:
 <2d4db6f87d2a8f8be36140aa7feabc7cdea87ec1.1648223504.git.geliang.tang@suse.com>
Subject: Re: selftests: bpf: add bpf_first test: Build Failure
Message-ID: <a9edb6cd-0f5e-5495-b402-2c9223e190e5@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Wed, 30 Mar 2022 16:54:52 +0000
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
org/project/mptcp/patch/2d4db6f87d2a8f8be36140aa7feabc7cdea87ec1.1648223504=
.git.geliang.tang@suse.com/
  https://github.com/multipath-tcp/mptcp_net-ne=
xt/actions/runs/2066154822

Status: failure
Initiator: MPTCPimporter
Commits: https://github.com/multipath-tcp/mptcp_net-next/commits/fa5a338aa3=
b4

Feel free to reply to this email if you cannot access logs, if you need
some support to fix the error, if this doesn't seem to be caused by your
modifications or if the error is a false positive one.

Cheers,
MPTCP GH Action bot
Bot operated by Matthieu Baerts =
(Tessares)
