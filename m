Received: from mail-il1-f182.google.com (mail-il1-f182.google.com [209.85.166.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42AC2625
	for <mptcp@lists.linux.dev>; Tue, 22 Feb 2022 06:19:00 +0000 (UTC)
Received: by mail-il1-f182.google.com with SMTP id e11so11788966ils.3
        for <mptcp@lists.linux.dev>; Mon, 21 Feb 2022 22:19:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:reply-to:in-reply-to:references:subject:message-id
         :content-transfer-encoding:date:mime-version;
        bh=yatXdl3utJ0WdbSwJOZ9kEDVSnsGr2syk8mpQM6hOqk=;
        b=QvVkGAAxmSpccl9uLGPin8nQMXHSZVIECcWINv8pfg4ozHdvii5Vw8OuLdCk3eXCXQ
         L4UCcQMra7iMJXcS/xQ1YSyjm5s3UVWs8uaXZs2GrygVicARBOjL3uX+ZWRbtIgOzqxx
         GZ2eTQPOlvALTQO5bl1y7UGvcRkuFZSZDnIX3LTb2SqEqaO11ru/kOtXk6ezoWZ7Hyua
         1wheTH1anf+Ry78CsiLXO0y63GEk1mjk0MeVIXHUlz8DZeZK2nJ5EXFUNjvovvoE6GAq
         tNWOFB+BCey5UiBNa23vCWc32us/utesdJf2wVKRB61ZYf3g4r3HAiPMWoCRI5+kYL91
         7r7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:reply-to:in-reply-to:references
         :subject:message-id:content-transfer-encoding:date:mime-version;
        bh=yatXdl3utJ0WdbSwJOZ9kEDVSnsGr2syk8mpQM6hOqk=;
        b=2ucJGdHCEetOduUVaM8DDOjb4h+lrmTxVNI7SY7yi4qEJAKpucw68WhWP/+RAjRDnu
         DBfRxmZYWg1TiMIZMowV8o4UOSxtgZrcoBt1iFPvZRMKsIz+Jv+DovbwS9VueUcmMkiw
         hkQj2WNbyBXkNhH7COSpRqlepAO9NQQpBtXexA5aQGEvX7vYCdFx/oSbRcX1Xn8eJJ4v
         ZbHagxoLupHo1I783f/fFD8AWKFJ3DhRHYa3HVymxe36fu61OJoepHlxgObm2rha9CeO
         6hLcpavz96o0ZnSuAHz7u1GThWG7DnsuFOlCo86/dqpz+EMkgO3k+TI0xGE47iS/a24Y
         38yQ==
X-Gm-Message-State: AOAM531H8uTm/TYNRuqzcE0Whe1bwPYQ5v5FXznKmP0ACXZsYLcjycc2
	xF9PUummaDQfW2Bv1U/iHQ==
X-Google-Smtp-Source: ABdhPJxllevPurlqCo04Bwpvz114bKb24t/XOYb1EuI3qtJEnsvq3ec/cWJ/h4Uu7gtkt0nLDwQGPw==
X-Received: by 2002:a05:6e02:1b02:b0:2b6:ae9d:67bf with SMTP id i2-20020a056e021b0200b002b6ae9d67bfmr18930749ilv.19.1645510739319;
        Mon, 21 Feb 2022 22:18:59 -0800 (PST)
Received: from [127.0.0.1] ([40.77.43.84])
        by smtp.gmail.com with ESMTPSA id m12sm11560667iow.54.2022.02.21.22.18.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Feb 2022 22:18:59 -0800 (PST)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <geliang.tang@suse.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <a355682307154e5fc4f26fc0957f00f931460905.1645510267.git.geliang.tang@suse.com>
References:
 <a355682307154e5fc4f26fc0957f00f931460905.1645510267.git.geliang.tang@suse.com>
Subject: =?UTF-8?Q?Re=3A_Squash_to_=22bpf=3A_add_=27bpf=5Fm?=
 =?UTF-8?Q?ptcp=5Fsock=27_structure_and_helper=22?=
 =?UTF-8?Q?=3A_Build_Failure?=
Message-ID: <883a3809-4be5-9f6e-2c96-b9e396801534@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Tue, 22 Feb 2022 06:18:58 +0000
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
org/project/mptcp/patch/a355682307154e5fc4f26fc0957f00f931460905.1645510267=
.git.geliang.tang@suse.com/
  https://github.com/multipath-tcp/mptcp_net-ne=
xt/actions/runs/1879950874

Status: failure
Initiator: MPTCPimporter
Commits: https://github.com/multipath-tcp/mptcp_net-next/commits/9af48d88e2=
c2

Feel free to reply to this email if you cannot access logs, if you need
some support to fix the error, if this doesn't seem to be caused by your
modifications or if the error is a false positive one.

Cheers,
MPTCP GH Action bot
