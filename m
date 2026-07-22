Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2232042BC3E
	for <mptcp@lists.linux.dev>; Wed, 22 Jul 2026 11:31:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.222.176
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784719900; cv=pass; b=tVqgMqVSErRhXH236MOXD2CIqUt77tNBlXthcU0lRQl9mlzDR4eCXCKNjWnl1rWGmAcHD93lD4zyt2n2Qa9SuHgMW+irk0qHOC6pYWnPzbUt0TmtHXeEJHAkTHLiK4nNhCGRFfoJYGIcd3k3lkjbd88DFtOYVF132RZAV5fGlJU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784719900; c=relaxed/simple;
	bh=xBxSszPrdvyPtWwG/4+6rb+5HbJaMyzlQVfk8xogBCo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ELwd1J2gnKK/QCu7qpCnDDk6iM7jqE7fK+ag/9fC6DTXEsbBfq81JBjAtJ9HsbddrNRtARQ0gHu8+oClfh2BnOmuImZ5eYVe/uSq/E+Rgs1PMkcccFqVZTf4WcY+8dn/lFujJ2mu8lD6+FsFI+i7onFQT5AE3vikr0L0XI4c2m0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G/79E/CA; arc=pass smtp.client-ip=209.85.222.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G/79E/CA"
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-9309d4ea213so725842785a.1
        for <mptcp@lists.linux.dev>; Wed, 22 Jul 2026 04:31:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784719892; cv=none;
        d=google.com; s=arc-20260327;
        b=Jmm4uPVsxv0pS/p4G0fXTCOCt8WtZ3DrmJjYc38FHMirQ1D7D2L+Xt91EUUN28dicP
         /OpGULdpS+KsRenJjaNxUDY1HZSID1Ns4C9de75cDJHWfZ/LficD4MxQAkB/OPmNhvLN
         +LfhF4st208U/WFriTc7xYVMKnmRNDC6Nv+fgYuXLiOrzYFRK0WI2KT0Ow8WeVyoa4J9
         rcu+VawzPFSFHnawWEsG8TAR5NBtD0tCbpCiEIDTbgIx9BDY+NQViPw6DLHr7/QNMY+l
         EiNK1yQEtiLYhuzbRFW8pAw834Q9ho+T40jfRsozcrLqvkj+KSR2HHDdURCrUhwRAj+Z
         dL9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=+AjNNGtU2rNOL7AfWz0JeUtzDJD3qx/w0PKZLpgVujE=;
        fh=CeUjXhDHWdUcYiHIGhU9tpsx428DraWEedi+iafsn5g=;
        b=VyrEYtXWO+D/UPd7PiDtvGQ3GNjoextcxsga/vOQrE5YnHEYoEMgj7vx64xh9oh7s/
         rDq1ShYHS3CiI5OIhk0z747yNGYPLY/+/3XUMIKmy6Xp4g0QSUZzI1GYCoESuVzwLs+i
         AZW/DJbig6IkC1cwW0AMOUBeRAN0fkpapLalXCZFaU8mYMj4VnLRdl/D4TUj97GDPCnQ
         ytjOMBJe0uUOzuCFrzsBHHc00pM295dKieRjuhywGMc2gg15Z8nG2SfNaYGUSnqx45PB
         PZcyj2j5qBOeP8z/c2Pu+eqrMUd9E/EcWDZ4/0ENCrefCzjtjltA/MnPN1cdDvn8yXhS
         GXug==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784719892; x=1785324692; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=+AjNNGtU2rNOL7AfWz0JeUtzDJD3qx/w0PKZLpgVujE=;
        b=G/79E/CAMj+Eya3nL7rseyJi0QWnsoeQroV58Vu4rRFCrNelrbLqFYHfhs4070CCOB
         jYTurwMZo56Xs+dbWmVrGcrG7zqNrszL187j9nplrjWrkhcapkvXPA3MS273FnbDYaJZ
         MjkJ1f5n8fEuzq1IZr7h+8smDu2OobcSQ7wjjCrTASAp9dz9oYlVcZJK8VN3VwyOfNjk
         Ay1FrtVoAs2fPoHiymddz2he6nXgQubVbxbS7gBCozn2t5ehihmHXrWyJ2cjzOm9mHI5
         93wZhpjfNCfOEb98ETRMf9bq6vslTZHER4R9vQ1Zd1qIntkz660DVKLNBL/Db7IcxBqr
         dpuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784719892; x=1785324692;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=+AjNNGtU2rNOL7AfWz0JeUtzDJD3qx/w0PKZLpgVujE=;
        b=ol9eD6r/jOu7js/6bZPZkEKmIoo+wHKl3yP7+VLZU5z1E1LCuNWO6WbvqYRf+bxwzu
         NN3Q/dnlzaZ+v06pzrLcu4qS+Jw68hR0y9q801lWCgXcvf1PDACS0KlFq1Ax+W8sHj9N
         PGBHEWrM4TAeMJT3UOxlBF6Ur1yakL63T0vJhRwckTjO+Osfz2tu8fwMBFqapoBEpqxf
         EJkz9/P6EeZrnVvQ6Yh5xs2qVtSF0fZ/v0vZCuRJbUD8HOgaDb+Pdvpj8is5joHmwRL1
         PMbaKCQDFjhjRME+0S+TnXTeMZVXK5b49G09Txi8+kj0S/f/ywIxjJD4R2NkGlTabnPa
         8CSA==
X-Forwarded-Encrypted: i=1; AHgh+Rq0DClhcucau8s8XtUO8S5FZqRzG8oLMdXVcXI/wzWi+xik/kCeuqPYtFoPfnsNJHmjt9tvIg==@lists.linux.dev
X-Gm-Message-State: AOJu0YwYbB8rqRU3ZV7VhhrfoBZLg5HOMPfYCR9bpYeRtVXK+Ly11K1l
	Cz43y2ibgpNoE92LawqLRNx7CO5MxbvZke8exjSW3vtNxKaaKDqAlSGWIzoC5XJHVkmIQTWmOqE
	TMJDQVj0EYeqMg2AsmzLD3WL9R48FIs0=
X-Gm-Gg: AR+sD13nz8aJY2y8vZqVYE9aXQ0hPawaH4+MCDgfVKasCf+e4LzeWXUsxJmunn2wZgn
	jLao1OY0t+/84kIsd+cFk5Nc8z/gp0+NvKfLcREmcvZxYP642vgr45dwN9N0tw0hkVqQeCdsurK
	ls+0ua1qIsZJdseChO2kRnHZ5oHPfsaHuXSE/WsnDnPa+cKbrBkrG5bWjutOtIxX3uqlyDQ+lc/
	Ic+07PMQxJbc/t0CULCanf8Vt/SLM8nsTx6/Si64ATGYuvXB5FP+a3tUZGWTB+r7+7PMvl0
X-Received: by 2002:a05:620a:6187:b0:92e:c117:9ea7 with SMTP id
 af79cd13be357-930b4393bf8mr2076258285a.85.1784719892325; Wed, 22 Jul 2026
 04:31:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <cover.1780458440.git.bronzed_45_vested@icloud.com>
 <81f26b8fddd59ebb6cecc417fb138d9ff5214e08.1780458440.git.bronzed_45_vested@icloud.com>
 <178471846217.973832.14121853580804517391.b4-review@b4>
In-Reply-To: <178471846217.973832.14121853580804517391.b4-review@b4>
From: Yuan Tan <yuantan098@gmail.com>
Date: Wed, 22 Jul 2026 04:31:21 -0700
X-Gm-Features: AUfX_mx8xqt1uALeyrzL7k_-AEqvUGxzYUcmdR3JYr4FcqhIKM2SAr55rEAlxo4
Message-ID: <CAPuPA7KaNrGZBO0LpgHJ=cwSH882D-Gs6bCVput3gyrhTubTFQ@mail.gmail.com>
Subject: Re: [PATCH mptcp_net-next 1/1] mptcp: fastopen: only mark MPTFO
 subflows with SYN data
To: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Cc: Ren Wei <n05ec@lzu.edu.cn>, netdev@vger.kernel.org, mptcp@lists.linux.dev, 
	martineau@kernel.org, geliang@kernel.org, pabeni@redhat.com, kuba@kernel.org, 
	dmytro@shytyi.net, yifanwucs@gmail.com, tomapufckgml@gmail.com, 
	zcliangcn@gmail.com, bird@lzu.edu.cn, bronzed_45_vested@icloud.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 22, 2026 at 4:07=E2=80=AFAM Matthieu Baerts (NGI0)
<matttbe@kernel.org> wrote:
>
> Hi Ren, Wyatt, Yuan,
>
> > Passive TCP Fast Open accepts a valid-cookie SYN even when it carries
> > no data. In that case the child socket's receive queue is intentionally
> > left empty.
> >
> > mptcp_fastopen_subflow_synack_set_params() set is_mptfo before checking
> > for queued SYN data. That made data-less TFO SYNs hit a WARN and, if
> > the warning was non-fatal, left stale MPTFO state behind. The stale
> > flag could later trigger a state-confusion bug in
> > check_fully_established().
> >
> > Only mark the subflow as MPTFO after confirming that a SYN-data skb is
> > present. Return quietly when the receive queue is empty.
>
> Thank you for the fix, it looks good to me:
>
> Reviewed-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
>
> @Netdev maintainers: this can be applied directly in net.
>
>
> Sorry for the delay, I initially wanted to understand the reproducer,
> then wrote a small packetdrill script, then I lost track of this patch.
>
> As I mentioned to Yuan last week at NetdevConf, it would be great if the
> PoC could first try to use Packetdrill when it is doable. For example,
> in this case, this packetdrill script appears to be far more readable
> than the .c files generated by AI:
>
>   https://github.com/multipath-tcp/packetdrill/pull/202/changes
>
> =3D> It is easy to read the syscalls, the injected packets (<) and the
> expected ones (>) with an output similar to the one from tcpdump.
>
> Note that for MPTCP, this fork should be used:
>
>   https://github.com/multipath-tcp/packetdrill
>
> Otherwise, the official repo can be used:
>
>   https://github.com/google/packetdrill
>
> --
> Matthieu Baerts (NGI0) <matttbe@kernel.org>

Thank you very much for your review. After receiving your suggestions,
I asked Wyatt to prepare a packetdrill version of the PoC for this
bug, but it is not ready yet. I apologize for taking up some of your
time on this review.

For future patches, whenever possible, we will include a packetdrill
PoC in the cover letter and send it to the public mailing list. We
will also use a new Reported-by: Vega tag instead of the tag we are
currently using.
