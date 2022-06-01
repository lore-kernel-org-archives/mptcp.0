Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C984C256F
	for <mptcp@lists.linux.dev>; Wed,  1 Jun 2022 14:21:04 +0000 (UTC)
Received: by mail-qv1-f47.google.com with SMTP id q15so740889qvy.8
        for <mptcp@lists.linux.dev>; Wed, 01 Jun 2022 07:21:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:reply-to:in-reply-to:references:subject:message-id
         :content-transfer-encoding:date:mime-version;
        bh=1S1cARBPoph2NNvxMYzQvF8eT54zlnGbcJna3RumVes=;
        b=iapqgVhrpudsxP4Pa8seqErz7k2fGs9Tmqxn6T5BIoYYG16NnXtItMTGA4CkZdl5p8
         d1PhH6kQ4CK5jwP/WP8W7CvyMTfJLTdgse0FJpoaoMNZjbn3IZei3oJLnywGoaWbmJeP
         BNitAOZ4odDYZfC0ynSR/5OW0Kz0PMLgJmANofa20P3rpkuLvsK/ZawnJVEP7q3LpBr7
         lBF8On4iY6Z23yTxXtblOH8BpR9uj8pwHVghzgSeYQBT5tMTh0rIPsRCMoyK1kSUInJG
         nP5H+VQJ9r85JD1FSf3AAJ+fjn9+Kl2lJfxBKPMhdOqRcmMt4AfHN7Uw3ymmvJAxEuOK
         cq1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:reply-to:in-reply-to:references
         :subject:message-id:content-transfer-encoding:date:mime-version;
        bh=1S1cARBPoph2NNvxMYzQvF8eT54zlnGbcJna3RumVes=;
        b=uzfaktVMZu+RHO9P/PvzJ1Xl1/U/OXVrYtqawB/JreTYzA5j7Fkq8ILxWy2CkVlrhm
         v3kL5LflwQbcpHPFBiP3DnbBJUZ/VEM4EJmQIp3yue+WP4H5cPCClz5LuSETNKSSh6AT
         7cGLr9L7DIj9vBR2wk5H3xTbEVMJmI487jd/mDfIGuJMeFYWFSU5pyM2n6ox+WHPdAU0
         j+sgoLr5Hnl3C7EKaQALP/sah0hzVMBEmNAr1itwgFHxJQVM/jGAshi4VaDrzPNff17m
         TbIhznAbqAYyVRhBFtk4YTn/rKVVjWziG09T+68YT9E74+Lf3J8Q4haMKzN0c/WJ5Lws
         rPiw==
X-Gm-Message-State: AOAM530rFp3PwBHNxY2PrAR50PLYKV5uDg4sSWPZBfJjwNc1ChIAmupP
	jWIqe2LTfHhMKC5lxiAauA==
X-Google-Smtp-Source: ABdhPJyil/BPNybiCBRbRbpQwkcFHHkTEYLL5FYCrllZSuil79fYCGDImgI6xUD6FKmfQbNndw5MGQ==
X-Received: by 2002:ad4:5cab:0:b0:464:643b:1099 with SMTP id q11-20020ad45cab000000b00464643b1099mr6147746qvh.95.1654093263372;
        Wed, 01 Jun 2022 07:21:03 -0700 (PDT)
Received: from [127.0.0.1] ([20.231.51.156])
        by smtp.gmail.com with ESMTPSA id i12-20020a37c20c000000b0069fc13ce20asm1298108qkm.59.2022.06.01.07.21.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Jun 2022 07:21:03 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <geliang.tang@suse.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <94de6d463bde36d3ad8e50324b9c40ce9ae36467.1654092153.git.geliang.tang@suse.com>
References:
 <94de6d463bde36d3ad8e50324b9c40ce9ae36467.1654092153.git.geliang.tang@suse.com>
Subject: Re: selftests/bpf: add bpf_rr test: Build Failure
Message-ID: <dbd58b00-6a0d-91fc-c739-8f8c453b0c42@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Wed, 01 Jun 2022 14:21:02 +0000
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
org/project/mptcp/patch/94de6d463bde36d3ad8e50324b9c40ce9ae36467.1654092153=
.git.geliang.tang@suse.com/
  https://github.com/multipath-tcp/mptcp_net-ne=
xt/actions/runs/2422165357

Status: failure
Initiator: MPTCPimporter
Commits: https://github.com/multipath-tcp/mptcp_net-next/commits/4d61a8b660=
c4

Feel free to reply to this email if you cannot access logs, if you need
some support to fix the error, if this doesn't seem to be caused by your
modifications or if the error is a false positive one.

Cheers,
MPTCP GH Action bot
Bot operated by Matthieu Baerts =
(Tessares)
