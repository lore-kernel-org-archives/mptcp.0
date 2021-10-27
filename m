Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C3912C87
	for <mptcp@lists.linux.dev>; Wed, 27 Oct 2021 10:32:28 +0000 (UTC)
Received: by mail-qk1-f178.google.com with SMTP id br18so1942791qkb.1
        for <mptcp@lists.linux.dev>; Wed, 27 Oct 2021 03:32:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:reply-to:in-reply-to:references:subject:message-id
         :content-transfer-encoding:date:mime-version;
        bh=b/RLyerJs0fWtOp4aIp6JkFvPw++OBy/1CMlq+1SgZc=;
        b=ox905zEC47ZLrTnA7DGAl9Siq0yf9mGjAN4NrkbnuiIAwBIDfxAD2T+cq+cYjytYqH
         L8n2/U6/NuzUUT1SwrXNbi+9n/RmZsY9AKspHowilsZiDtO+yvpvLLA9ZKYP2lGT940+
         k7YeaQZmzTjTrUtM+RNqtZyn5AM2nSK6Fq26zyPV0ENx1X01vXcSL6ZR+Lm1d3EARwoK
         +pvFrUqi2H9lVVkU4phqbe5I+gRHpye5BJzlXjOfckkzZQbKM+UDm5kgbCmpLs4gDh88
         7zes3FE3X6UXPFzvujw+/AHeJoX2bNcMmcfiS3GakNyRj17aBqijmML5cmDh6SH2B/Fy
         GWTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:reply-to:in-reply-to:references
         :subject:message-id:content-transfer-encoding:date:mime-version;
        bh=b/RLyerJs0fWtOp4aIp6JkFvPw++OBy/1CMlq+1SgZc=;
        b=h7xgCl4rvJ9hvjRIQ24pHZw78ccLxT7/h6mPac4R22YBuNjTmteq1TpPdhjQGGSOnI
         rAebE2X6AK8jzo4OEB+/S+v13mBTOPlgsCTcTxKgpvj0T+Id18F9L8jda+l0CgTR+5uD
         syWSOF176FT2r4B8BX1iJmlf+g1fVXkagPOYG17VXY/M1kazHGiAbiOjm27UPgGNrPy8
         dX+eeYHrz1MuwZ3OE2p3DKPpgya1uaBwEuyhIwkZzFSH/0YnpAqE7dvtTyCFRChqnmVr
         yJljsrUBeehB/9FsMzS9I1zv8MwmAyBMfYKn0yL2JXYJELe5chHaFt+Of19qNVfJe8Lv
         ibKQ==
X-Gm-Message-State: AOAM532H7QneWHHMBlSlIXMhUsgO6dbLP9UhX9XGbX9NbDZ37SiZ9zd1
	cfiuSOC7Lk0MHEty/sW3zkXPGJI0tQ==
X-Google-Smtp-Source: ABdhPJxyb6v0RmiFe4FHiBwesPvMS5/lb6kT1yMM3T2oUE5F2FHqpOgKv7YBZ/fkKX+QvHEMFPCTXQ==
X-Received: by 2002:a05:620a:4411:: with SMTP id v17mr22537327qkp.431.1635330747116;
        Wed, 27 Oct 2021 03:32:27 -0700 (PDT)
Received: from [127.0.0.1] ([104.209.238.248])
        by smtp.gmail.com with ESMTPSA id d6sm12126385qkj.11.2021.10.27.03.32.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Oct 2021 03:32:26 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <geliang.tang@suse.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <98ce131530c3ae91bf2ca29e6566ca1f7debe202.1635330390.git.geliang.tang@suse.com>
References:
 <98ce131530c3ae91bf2ca29e6566ca1f7debe202.1635330390.git.geliang.tang@suse.com>
Subject: Re: selftests: mptcp: add mp_fail testcases: Build Failure
Message-ID: <4474733d-0a7e-1ddc-d05d-9a9cdaa9ace5@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Wed, 27 Oct 2021 10:32:26 +0000
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
org/project/mptcp/patch/98ce131530c3ae91bf2ca29e6566ca1f7debe202.1635330390=
.git.geliang.tang@suse.com/
  https://github.com/multipath-tcp/mptcp_net-ne=
xt/actions/runs/1389695481

Status: failure
Initiator: MPTCPimporter
Commits: https://github.com/multipath-tcp/mptcp_net-next/commits/f1240fddd1=
e2

Feel free to reply to this email if you cannot access logs, if you need
some support to fix the error, if this doesn't seem to be caused by your
modifications or if the error is a false positive one.

Cheers,
MPTCP GH Action bot
