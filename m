Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0C6F31715B
	for <mptcp@lists.linux.dev>; Mon,  1 Jun 2026 05:44:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.169
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780292688; cv=pass; b=OELKFdKW3czDagYuZw7/ky9Sy+6qSzrofxvu9D8xIWxO1emFDHObeO09LQqVVuZmqBO3HINORCL5ww+gz3AsEVfnWCVZZCpZzzxV0hXN22K4XUfap7CMD4+07LtpELmoqdYFPJmVVHqSjjU29Dp76i2+/7oZvZ91lIn8qaPbjms=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780292688; c=relaxed/simple;
	bh=3SEfUrGpOB+OrS2N/tF2ctbW+WT/uZ3USk5VMcVSXLA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=d7XnSKT7bC5kc6xDjRMg9mk45rMNhZpjRj2gJvmJE04GaJ5Gg1AI0fUu5CYL1OFe9+MN5HGrOFVuTQEMK76cpqt1qs71U7418Lnu4PWZUSTXIHjBr/OGhMak91YNPXpxBuR0F0SIH2s//XqVO5ZLH+pW0blX0ymExrHTFTwUkYc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=JFavQMjQ; arc=pass smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JFavQMjQ"
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-5174a1f2d45so5100601cf.3
        for <mptcp@lists.linux.dev>; Sun, 31 May 2026 22:44:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780292685; cv=none;
        d=google.com; s=arc-20240605;
        b=Ylv9l8zAh8T8skoGFw8eaPgfha5GA6wEetig0e3wHJyHLnf7JSz8WZMfDPWxVsS8Bn
         Mm/N6T/QwohIsjKibCwXpsm0Gx+yWd/S/sOdP5zNkqaQkwxUG5zljzl/3CFEZ/cqK0oB
         FU+IJGBepNU3M4jheRV3czzYINgT/rmq4W3u92FWL5SQWOjOxCjGfwibFZ5raMAdzRXU
         ixH9UR6XqmLlvom0iaCB49M0TuY6Ro4caZbpagkwjYa5gzPmC3RaW9b+rHvnCwqoj1Mx
         EFCd5RJPhMMAp/cZc0DE+hXebrXy6c4e0dXgJQMcQ3fV3ZQK9+QKIuqoeReZMaKSf2C5
         TT/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=CYJ9us5FFWuw1Ubnqm5Mv6Rgk1trKuije/O9oTp1I54=;
        fh=YU2wqw8wLwFD+cechH4cmMqMrpiQX5cQQZ9Ujjm80rk=;
        b=NYQWLbX5Up5Y3tHgniwkKFsHdZ1H8GDBGU05fPOB+mwoTYCU2KFdokBd2D463M4QCy
         5sXCFSUQI/acOggRs0stmz+RfKoff59PpTZ+Sffi4ZjFvT3LOaBgZkdAUkA7RmmSwVUn
         m3l2eQUhGTsMlpASKLqAx5l5RAtDUHFcx9o1ySpVnbzdo/l2MvjtO5IisxmHk+OQGHWB
         Pe6gib9D1N/JMJcckcyD1i1mDhQKrkh/WXwS340R3njlq1D3p/Xf30ob2vBehNpYMSgQ
         wD9O+4ZkL2teu8qsfUr6ODJBLeLbDSpaHXCPUBQqMI71cfSOC25c3pWnAhNiBC/glB7J
         bOOQ==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780292685; x=1780897485; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CYJ9us5FFWuw1Ubnqm5Mv6Rgk1trKuije/O9oTp1I54=;
        b=JFavQMjQoSruTD7h2dwjOERl3y76xFgm1w89tEg7CzROa97DzHiqxhC7CclwZo7Jnm
         AoCMIoS6VF56b+8my2+iNBITc0yinnDxURpgwpgHvvjNQROHVO7rs+mHpnTKa2FcweGe
         4AqaKY783mJXwE0/xMRDocSafwmXC5wqU3Dobh8iISnKC9rpRlIQEcMjXhnNIhZGyMpp
         wLaeXMiO74TsbhpT5Lw71mEZIT85wDq1WZL025AVsZI85u3zqF5Aqn04Axea/gzvs59o
         h9UERRGTjwHgDgPOPo0Vbw9oTNb8l4ikrPWy6yz2Ru4hfeiMTnaatddjaHVwsi6Ias8x
         EYjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780292685; x=1780897485;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=CYJ9us5FFWuw1Ubnqm5Mv6Rgk1trKuije/O9oTp1I54=;
        b=rLDoTU1dGXs+a9DG+aejh607nv0rezKkgez8chzgDAHy6VhaT+J/B1juerEk7TJ8ur
         wnLIa3KdKoGRMCNayN9vcyj6iNZcjdNFORG5o4xJ/5j0kVul2nmj9NQRlno2hPeRylXm
         fW0I93OffuifhWyQs6FnsH7J6ITdRXhyHaTbxkB3fvMCsyfQRlUkcyPCY4STd/48WCJu
         rpLcWL+k4VIH3+S5M6eP96jfvHNx0wPfB+3CBiedniw5j6e1YmLWyn2g4Zra96goLS0z
         6bnULG17FbhZ2KI4yvl63NHJIzpQYyfTjVorlS2w1TAyAfSQrscAw4gCNyBGQA3KjnWw
         2vaA==
X-Forwarded-Encrypted: i=1; AFNElJ/RD/YBgCloeKBj6aahWl9cu5rpUQzG/5SaaPASmBahUeE4+2Av0OApFNJLowP/nNWpc/9x5w==@lists.linux.dev
X-Gm-Message-State: AOJu0Yxs1aBp5k/0SK/8dI0hNJ3ne4/RK2N+Ygh7SknL5/5KARyLAAzK
	GXzUqBgkqZ7zuhri46wrVgzv1wBely0OY3q3C8x7HAjVimHIRTuRvuWS08kklqxt2tlWvAIGaF8
	5czUX9wf8d2Y2RJDtD5wT6AHvh+gaC8dcjZ+MkhXM
X-Gm-Gg: Acq92OEzdmBgB9cjM5LfIHJXOsyzWXVb6lCx6j5SEQsA7b7JSKJR+eC0CH6+rBwWeN9
	/u3Oxq4XC0Qx2/EOkFEZ/7YqObGVSIKJnjLduhMGcgDfOG7LNd/ywhJ0k65ibyhBC7ixOqGMIf0
	g/nEMa+7wCXsEjvQcP5UoXPWxeI6A6FbWTWlyA3ksgqLz7WUJtLXmY9fIAcn+NmnosDYsRmXiVp
	882ACfYW6ZKQasWFlp1vVt6a/g0M6QiLZNvpRBFJrgCZlxnxQhYpyFZDuQN2ge7KO4A8XAuySvC
	It4J0ds5YnXS5EUyUdEGko7U/R0egdIDyJCJKknvBmChX+zZJ5PR5plW91rIUvCsBZkOPEBi7Pp
	bDfWKYXQrvfIyvjbkeC/got5MiyJc
X-Received: by 2002:a05:622a:1106:b0:517:5790:ff7b with SMTP id
 d75a77b69052e-51757910b7amr22711931cf.57.1780292684284; Sun, 31 May 2026
 22:44:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260601-net-next-mptcp-add-addr6-port-ts-v1-0-4fc25dfef62e@kernel.org>
 <20260601-net-next-mptcp-add-addr6-port-ts-v1-4-4fc25dfef62e@kernel.org>
In-Reply-To: <20260601-net-next-mptcp-add-addr6-port-ts-v1-4-4fc25dfef62e@kernel.org>
From: Eric Dumazet <edumazet@google.com>
Date: Sun, 31 May 2026 22:44:32 -0700
X-Gm-Features: AVHnY4IayHyy6cMDi-nQDDjXrYJHGRD4C69UxZMSkBfLGuSFxlZymzrG3JPQpdU
Message-ID: <CANn89iL=os-60kDKqMDdyiXuPF5CG=eejS0vmthwpDGXz_Bp8A@mail.gmail.com>
Subject: Re: [PATCH net-next 04/11] mptcp: introduce add_addr_v6_port_drop_ts
 sysctl knob
To: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Cc: Mat Martineau <martineau@kernel.org>, Geliang Tang <geliang@kernel.org>, 
	"David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, mptcp@lists.linux.dev, 
	linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>, 
	Shuah Khan <skhan@linuxfoundation.org>, linux-doc@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, May 31, 2026 at 10:24=E2=80=AFPM Matthieu Baerts (NGI0)
<matttbe@kernel.org> wrote:
>
> This sysctl is going to be used in the next commits to drop TCP
> timestamps option, to be able to send an ADD_ADDR with a v6 IP address
> and a port number. It is enabled by default.
>
> This knob is explicitly disabled in the MPTCP Join selftest, with the
> "signal addr list progresses after tx drop" subtest, to continue
> verifying the previous behaviour where the ADD_ADDR is not sent due to a
> lack of space.
>
> While at it, move syn_retrans_before_tcp_fallback down from struct
> mptcp_pernet, to avoid creating another 3 bytes hole.
>
> Reviewed-by: Mat Martineau <martineau@kernel.org>
> Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>

...

>  };
> @@ -94,6 +95,11 @@ const char *mptcp_get_scheduler(const struct net *net)
>         return mptcp_get_pernet(net)->scheduler;
>  }
>
> +unsigned int mptcp_add_addr_v6_port_drop_ts(const struct net *net)
> +{
> +       return mptcp_get_pernet(net)->add_addr_v6_port_drop_ts;
> +}

Please use READ_ONCE() over sysctls.
This will avoid future patches from KCSAN bots.
