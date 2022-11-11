Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 783C2652
	for <mptcp@lists.linux.dev>; Fri, 11 Nov 2022 08:12:08 +0000 (UTC)
Received: by mail-pl1-f182.google.com with SMTP id p21so3674553plr.7
        for <mptcp@lists.linux.dev>; Fri, 11 Nov 2022 00:12:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=koDD+cLgP/SR4oTjVAmInFRNRs1Od/UjiHOqcBV3zzw=;
        b=VV7c3Qo4RV38h9vjdmGDRSEmRHgtxEDurE2vgSteuB+di4qtwoxD5h52g+l6S7CSHS
         ckFKOZ+zmrSAYttEp+LMbTOU/xZh3/9mFOGXcsKmNIYZVi/4N5pO46JVoAhF57adQI4F
         V2tNMsO9axbkTiuvAGLQ/hP63sLW2Ebj92dqaUkSV4EL6fxiex+yseRhztoToq+X+W7g
         bz5mWP7o38f9XU2YrehqsAZ9lvkrXESf+cShXSvMmuS+q+Aofsy6IYcyfbMFtxjb438a
         QKLtqvZEg7zzAbxQiOhIG6cmNxMS654GFSa67p50w8lHxQr7thsD+TR7GTxefuLk74s3
         JG9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=koDD+cLgP/SR4oTjVAmInFRNRs1Od/UjiHOqcBV3zzw=;
        b=3FyjpJjTw66SivY8+VlbdMQMnygP8J6NWJhT/E5I/IPh5RsrKB6rv1u3kEPBKAQMWu
         5UuYlVKqkK8lV6EAv2E3atMM3DxYVP1Q1kOwbXCk0tcYhqcjKIef7psLjdiMYMz7sgjI
         sEftZxOca9xSmHODFByrCE0XyDcbDc3vtPkwXZvZBSukeszvwhVGM+VguEQ3NsYkQN9x
         KrJH9MMtRKDNva6Wec5Sc4SrD2o+NkmEZblCbwDz1ZQltCWFo4lc++UEaCmTitnUJNda
         PmZ7s+DI3AtrOaAEZimNiwp1a5mJ3nbegsgvDYoVTsw+56YoTSK7XeO3ZvMe4lu8vhaG
         u1tg==
X-Gm-Message-State: ANoB5pmySkzYFky3mjb9wAc/wl1gj1pKl70Q0FWJtT98WdX2JgmRsaeD
	gdsXeF7+drGU1HhNeyUmgQ==
X-Google-Smtp-Source: AA0mqf7hb2GMeWp7aW1srkWKA+yOJb60nf2jmKMKz0TM92fb76VsXXq0+aGd0kcR5wNQpt3Ym8/znw==
X-Received: by 2002:a17:90b:2784:b0:213:d1d5:d661 with SMTP id pw4-20020a17090b278400b00213d1d5d661mr789069pjb.43.1668154327876;
        Fri, 11 Nov 2022 00:12:07 -0800 (PST)
Received: from [127.0.0.1] ([20.245.150.17])
        by smtp.gmail.com with ESMTPSA id f13-20020a170902f38d00b00181f8523f60sm1018937ple.225.2022.11.11.00.12.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Nov 2022 00:12:07 -0800 (PST)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <geliang.tang@suse.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <d1d8d0acb444c6ac39eb6ae945bf439d633e74b3.1668151131.git.geliang.tang@suse.com>
References:
 <d1d8d0acb444c6ac39eb6ae945bf439d633e74b3.1668151131.git.geliang.tang@suse.com>
Subject: =?UTF-8?Q?Re=3A_Squash_to_=22selftests/bpf=3A_Add_?=
 =?UTF-8?Q?bpf=5Frr_scheduler=22=3A_Build_Failure?=
Message-ID: <c11c2187-c611-41bf-cb77-c88c49de96d8@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Fri, 11 Nov 2022 08:12:06 +0000
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
org/project/mptcp/patch/d1d8d0acb444c6ac39eb6ae945bf439d633e74b3.1668151131=
.git.geliang.tang@suse.com/
  https://github.com/multipath-tcp/mptcp_net-ne=
xt/actions/runs/3443397477

Status: failure
Initiator: MPTCPimporter
Commits: https://github.com/multipath-tcp/mptcp_net-next/commits/b52f03a919=
14

Feel free to reply to this email if you cannot access logs, if you need
some support to fix the error, if this doesn't seem to be caused by your
modifications or if the error is a false positive one.

Cheers,
MPTCP GH Action bot
Bot operated by Matthieu Baerts =
(Tessares)
