Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.219.41
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793266750;
	b=s2sMPPs5i6630bTmI/UvsZ81TGnAu7Ri3SmvsXxqVeVuqVg211+pt7Bwbviavf5qufwl
	 jsccy57ZGDlMZNnGnWaLIzLKkhb+D1bnPLjWdwVX9nLpTIsxYaG7mKdT11UqksGzOi15g
	 Q9Mkj62uShwpwduViyXLSaduURiKqOoHP3L6nXD84YO+rbJIhg8SYQSGpuv8ufhA7vkXO
	 GXI6VCWT2uwnQmx2jm9hbHUMwhhvk18lxhZdGazCejPWnYVQYo1T+fEW9p90J9eBkvDR6
	 cUxXwaBh8DM38Fo9GV7d95PB6kcz6/2zA/kuCyht2TBG2Wouok5hj1kqhnkIpCItOew==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793266750;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Reply-To:
	 In-Reply-To:References:Subject:Message-ID:Content-Transfer-Encoding:
	 Date:MIME-Version:Content-Type;
	bh=dygGwsoQ66GCvlJ2ECqK/bQRvkatdKMPEYgEMMfT5Oc=;
	b=QK9Wo6LX0AfI2EzPSa3UxJIwk3uySTRNeCmAOJ34A9WXt/KweVA5umAkQaiVrHWKDL2C
	 A58oPDlxWqCYq/eg7ef2yJWdiTUhqs5pIFM3Rbo+nA8c9KexgLd6hvQ57RmQ0WIDrf8pF
	 xW3wu4oWwkyZtkamX1ov+Y+tRWhtqMsh+GCCHTZBW9FQLX2bKH6Q5odOt5mzdsX9niCIN
	 By1h0IzhqCM0oelZ4+VtUCzFZLnyREtyaP5r0U7eYHAs6YotDaoJdfcOEXkxNyB35NDWb
	 VM0zbRizElKhDpF4Tarc1QQcqszCdy2prA1VmIOOTS83E2+tz5RcYdCzr4WMxoppWKg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=UMMeeKw5;
	arc=none smtp.remote-ip=209.85.219.41
Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39C5B606A31A
	for <mptcp@lists.linux.dev>; Thu, 29 Oct 2026 09:39:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 39C5B606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=UMMeeKw5
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-91c7a0c1617so27331636d6.0
        for <mptcp@lists.linux.dev>; Thu, 29 Oct 2026 02:39:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793266749; x=1793871549; darn=lists.linux.dev;
        h=content-type:mime-version:date:content-transfer-encoding:message-id
         :subject:references:in-reply-to:reply-to:cc:to:from:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=dygGwsoQ66GCvlJ2ECqK/bQRvkatdKMPEYgEMMfT5Oc=;
        b=UMMeeKw5SD7KXhYz46Vjo5XYuhy6A1pDHg1nNRHN17EVuXKKfptLPxo8ElLtvnJe7h
         Nm3HwGpE+/N1vuZBJf5ulR6t1yV+lEH/d6mQ+hmXnUj3eXkFuSHJ/g1tjT9XLkAyY0aJ
         JkhoHiEo3vW7QrIuCkJTUg9wvxklDQkK0PNhX7Tic+S3/B5v7F3N/nPNQdNtHLzFxPP/
         n57xrXEbaMI3At6fYG/W3cHIc6ZmMn6PWbDBh6dNr/sALWPJtcjxht7cchAJLMjjXh9+
         Mm1zPDAqSKhAySuhbD6gG6eLYTbDMSidxg+jFMJGzbNF0gEo02qpnWCImP6ZhtpmHLRD
         eb6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793266749; x=1793871549;
        h=content-type:mime-version:date:content-transfer-encoding:message-id
         :subject:references:in-reply-to:reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=dygGwsoQ66GCvlJ2ECqK/bQRvkatdKMPEYgEMMfT5Oc=;
        b=2y4cySIbi29bwDZZt0T0v2qVncxOBYFJGb2BrNVKl91zuugk5tW8ZEHYwJfLCmnlP+
         F5Uqe4jPX5J+HGTFMXYRhE/8HICyanUnUEtIASb8hdh/oAmSae1lXXG9VniYMFgTP3QW
         FlfMy1CQbrMKiviSwbBTdLcbOTM69kbcJnz0qjmAJyRZBUHjwazCCeMbwkLOHdXTxHk6
         iE89qTcmozABZTebKRvRiXJVF8gJ0kJK6P5cUBS6pntbjT2sPh2K5ZbmKBOkc6dV0Vck
         QUWmm2vj4KGktdu/MxtQmasS3R/zUxloYdGGA+VgL37yNveX4v0GrbB01UBbDuwSccqi
         dRUg==
X-Gm-Message-State: AFq9FYLLLymZ8p5uNkpe2yVb7ZSGWjbH1On0IPZu7+HdLi0wWJOh774b
	lMTG3q9ZmpehvTEiselCLf6kiHEgEXc8BQf4QP1tpF1VHKvn446OWAQPokt+bh4=
X-Gm-Gg: AYBFou0s2vM0JOLGpA6VfQ9ZjCf90OKFXY+LiA0vjMn1uJe/eD1ncA9Dczuv5g8an6b
	/5zu3fOpT6fTstIj3MLe1sIAcgqsFxTuaI/93ZHZV3VYc4o2s0/PPha0BO2zy25Q13Ws714N4t1
	/8xDy0F0bYvnA5FbkRauesBHqfrR9FnuFlmH+5mzOkRMWoGROkA2Vw9UeVG/9Wjudqcb7dywFbh
	3oCluSF9C4S47m3Ls0MOet39AXyzInrrATmX0xyqHYe06tk9rYNXtazuApx2XL8fPbabL8NJi5R
	M7YxJOno6w5B6Tn1BpHUy3K8ujmONhaDHwXXCycyDaebh7PP+GwsMNeD6lWl6VS/thgqHNxtH9v
	gIG0auqI+RMesbkDwZEuxf/Zc2gOuu3/SbBcwStAyRWhDLqwh3Uuuj/kINHuas2J08qojdfYBKq
	hthLhzQ17jierosw67PynZ7FqYW8n6kZtpJ1rpVNEwgO/TUKQNiertIvxQq1RdfYjmAnIw99nD/
	2WQOQq7h0CjxxqEISl7KRXd0RZ2j/QjEZAR3D2oquOEpt7aax8xHyfPmC7yWDbEbpM4e3eaTM5+
	WOZKEpjM5Cu9bQsr7lfVTpwrlV6esN/1Xwo9ddpd
X-Received: by 2002:a05:620a:4010:b0:93f:11ee:ba5f with SMTP id af79cd13be357-94408d80c1bmr808074485a.79.1793266749042;
        Thu, 29 Oct 2026 02:39:09 -0700 (PDT)
Received: from github.com ([20.55.87.53])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-940f078ba99sm1497570485a.32.2026.10.29.02.39.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Oct 2026 02:39:08 -0700 (PDT)
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <tanggeliang@kylinos.cn>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <cover.1793258749.git.tanggeliang@kylinos.cn>
References: <cover.1793258749.git.tanggeliang@kylinos.cn>
Subject: Re: [PATCH mptcp-next v2 0/5] prepare interfaces for kTLS and
 sockmap support
Message-ID: <faab74f3-cfd8-fb63-19f1-44f803fd9011@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Thu, 29 Oct 2026 09:39:07 +0000
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Post: <mailto:mptcp@lists.linux.dev>
List-Help: <mailto:mptcp+help@lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
List-Owner: <mailto:mptcp+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8

Hi Geliang,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal (except selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: normal (only selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: debug (except selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: debug (only selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: btf-normal (only bpftest_all): Success! =E2=9C=85
- KVM Validation: btf-debug (only bpftest_all): Success! =E2=9C=85
- Perf: Critical: mptcp-perf/01-Test_1/client.log: Global Timeout - =
Critical: mptcp-perf/01-Test_1/server.log: Global Timeout - Critical: =
sched-baseline/01-slow_primary/client.log: Global Timeout - Critical: =
sched-baseline/01-slow_primary/server.log: Global Timeout - Critical: =
sched-baseline/02-tiny_primary/client.log: Global Timeout - Critical: =
sched-baseline/02-tiny_primary/server.log: Global Timeout - Critical: =
sched-baseline/03-fast_both/client.log: Global Timeout - Critical: =
sched-baseline/03-fast_both/server.log: Global Timeout - Critical: =
sched-baseline/04-balanced/client.log: Global Timeout - Critical: =
sched-baseline/04-balanced/server.log: Global Timeout - Critical: =
sched-baseline/05-slow_near_primary/client.log: Global Timeout - Critical: =
sched-baseline/05-slow_near_primary/server.log: Global Timeout - Critical: =
sched-baseline/06-slow_secondary/client.log: Global Timeout - Critical: =
sched-baseline/06-slow_secondary/server.log: Global Timeout - Critical: =
sched-baseline/07-very_fast/client.log: Global Timeout - Critical: =
sched-baseline/07-very_fast/server.log: Global Timeout - Critical: =
sched-baseline/08-shallow_primary/client.log: Global Timeout - Critical: =
sched-baseline/08-shallow_primary/server.log: Global Timeout - Critical: =
sched-baseline/09-high_lat_primary/client.log: Global Timeout - Critical: =
sched-baseline/09-high_lat_primary/server.log: Global Timeout - Critical: =
sched-baseline/10-huge_lat_primary/client.log: Global Timeout - Critical: =
sched-baseline/10-huge_lat_primary/server.log: Global Timeout - Critical: =
sched-baseline/11-high_lat_secondary/client.log: Global Timeout - Critical:=
 sched-baseline/11-high_lat_secondary/server.log: Global Timeout - =
Critical: sched-baseline/12-huge_lat_secondary/client.log: Global Timeout -=
 Critical: sched-baseline/12-huge_lat_secondary/server.log: Global Timeout =
- Critical: sched-baseline/13-bloated_primary/client.log: Global Timeout - =
Critical: sched-baseline/13-bloated_primary/server.log: Global Timeout - =
Critical: sched-baseline/14-bloated_secondary/client.log: Global Timeout - =
Critical: sched-baseline/14-bloated_secondary/server.log: Global Timeout - =
Critical: sched-baseline/15-slow_primary_upload/client.log: Global Timeout =
- Critical: sched-baseline/15-slow_primary_upload/server.log: Global =
Timeout - Critical: sched-baseline/16-balanced_upload/client.log: Global =
Timeout - Critical: sched-baseline/16-balanced_upload/server.log: Global =
Timeout - Critical: sched-baseline/17-slow_primary_parallel_4/client.log: =
Global Timeout - Critical: sched-baseline/17-slow_primary_parallel_4/server=
.log: Global Timeout - Critical: sched-baseline/18-balanced_parallel_4/clie=
nt.log: Global Timeout - Critical: sched-baseline/18-balanced_parallel_4/se=
rver.log: Global Timeout - Critical: sched-bbr/01-slow_primary_bbr/client.=
log: Global Timeout - Critical: sched-bbr/01-slow_primary_bbr/server.log: =
Global Timeout - Critical: sched-bbr/02-balanced_bbr/client.log: Global =
Timeout - Critical: sched-bbr/02-balanced_bbr/server.log: Global Timeout - =
Critical: sched-bbr/03-slow_near_primary_bbr/client.log: Global Timeout - =
Critical: sched-bbr/03-slow_near_primary_bbr/server.log: Global Timeout - =
Critical: sched-bbr/04-high_lat_primary_bbr/client.log: Global Timeout - =
Critical: sched-bbr/04-high_lat_primary_bbr/server.log: Global Timeout - =
Critical: sched-bbr/05-huge_lat_primary_bbr/client.log: Global Timeout - =
Critical: sched-bbr/05-huge_lat_primary_bbr/server.log: Global Timeout - =
Critical: sched-bbr/06-high_lat_secondary_bbr/client.log: Global Timeout - =
Critical: sched-bbr/06-high_lat_secondary_bbr/server.log: Global Timeout - =
Critical: sched-bbr/07-huge_lat_secondary_bbr/client.log: Global Timeout - =
Critical: sched-bbr/07-huge_lat_secondary_bbr/server.log: Global Timeout - =
Critical: sched-bbr/08-slow_secondary_bbr/client.log: Global Timeout - =
Critical: sched-bbr/08-slow_secondary_bbr/server.log: Global Timeout - =
Critical: sched-bbr/09-very_fast_bbr/client.log: Global Timeout - Critical:=
 sched-bbr/09-very_fast_bbr/server.log: Global Timeout - Critical: =
sched-bbr/10-bloated_secondary_bbr/client.log: Global Timeout - Critical: =
sched-bbr/10-bloated_secondary_bbr/server.log: Global Timeout - Critical: =
sched-bbr/11-bloated_slow_secondary_bbr/client.log: Global Timeout - =
Critical: sched-bbr/11-bloated_slow_secondary_bbr/server.log: Global =
Timeout - Critical: sched-bbr/12-very_bloated_secondary_bbr/client.log: =
Global Timeout - Critical: sched-bbr/12-very_bloated_secondary_bbr/server.=
log: Global Timeout - Critical: sched-bbr/13-bad_secondary_bbr/client.log: =
Global Timeout - Critical: sched-bbr/13-bad_secondary_bbr/server.log: =
Global Timeout - Critical: sched-bbr/14-far_secondary_bbr/client.log: =
Global Timeout - Critical: sched-bbr/14-far_secondary_bbr/server.log: =
Global Timeout - Critical: sched-clientlim/01-slow_primary_bw_5/client.log:=
 Global Timeout - Critical: sched-clientlim/01-slow_primary_bw_5/server.=
log: Global Timeout - Critical: sched-clientlim/02-balanced_bw_5/client.=
log: Global Timeout - Critical: sched-clientlim/02-balanced_bw_5/server.=
log: Global Timeout - Critical: sched-clientlim/03-huge_lat_primary_bw_5/cl=
ient.log: Global Timeout - Critical: sched-clientlim/03-huge_lat_primary_bw=
_5/server.log: Global Timeout - Critical: sched-clientlim/04-slow_secondary=
_bw_5/client.log: Global Timeout - Critical: sched-clientlim/04-slow_second=
ary_bw_5/server.log: Global Timeout - Critical: sched-clientlim/05-slow_pri=
mary_bw_10/client.log: Global Timeout - Critical: sched-clientlim/05-slow_p=
rimary_bw_10/server.log: Global Timeout - Critical: =
sched-clientlim/06-balanced_bw_10/client.log: Global Timeout - Critical: =
sched-clientlim/06-balanced_bw_10/server.log: Global Timeout - Critical: =
sched-clientlim/07-huge_lat_primary_bw_10/client.log: Global Timeout - =
Critical: sched-clientlim/07-huge_lat_primary_bw_10/server.log: Global =
Timeout - Critical: sched-clientlim/08-slow_secondary_bw_10/client.log: =
Global Timeout - Critical: sched-clientlim/08-slow_secondary_bw_10/server.=
log: Global Timeout - Critical: sched-clientlim/09-slow_primary_bw_50/clien=
t.log: Global Timeout - Critical: sched-clientlim/09-slow_primary_bw_50/ser=
ver.log: Global Timeout - Critical: sched-clientlim/10-balanced_bw_50/clien=
t.log: Global Timeout - Critical: sched-clientlim/10-balanced_bw_50/server.=
log: Global Timeout - Critical: sched-clientlim/11-huge_lat_primary_bw_50/c=
lient.log: Global Timeout - Critical: sched-clientlim/11-huge_lat_primary_b=
w_50/server.log: Global Timeout - Critical: sched-clientlim/12-slow_seconda=
ry_bw_50/client.log: Global Timeout - Critical: sched-clientlim/12-slow_sec=
ondary_bw_50/server.log: Global Timeout - Critical: =
sched-cpu-preempt/01-shallow_primary/client.log: Global Timeout - Critical:=
 sched-cpu-preempt/01-shallow_primary/server.log: Global Timeout - =
Critical: sched-cpu-preempt/02-shallow_primary_cpu_hog/client.log: Global =
Timeout - Critical: sched-cpu-preempt/02-shallow_primary_cpu_hog/server.=
log: Global Timeout - Critical: sched-mem-pressure/01-bloated_slow_secondar=
y_receiver_tcp_mem_parallel_1/client.log: Global Timeout - Critical: =
sched-mem-pressure/01-bloated_slow_secondary_receiver_tcp_mem_parallel_1/se=
rver.log: Global Timeout - Critical: sched-mem-pressure/02-bloated_slow_sec=
ondary_receiver_tcp_mem_parallel_16/client.log: Global Timeout - Critical: =
sched-mem-pressure/02-bloated_slow_secondary_receiver_tcp_mem_parallel_16/s=
erver.log: Global Timeout - Critical: sched-mem-pressure/03-bloated_slow_se=
condary_receiver_tcp_mem_parallel_99/client.log: Global Timeout - Critical:=
 sched-mem-pressure/03-bloated_slow_secondary_receiver_tcp_mem_parallel_99/=
server.log: Global Timeout - Critical: sched-mem-pressure/04-very_bloated_p=
rimary_both_tcp_mem_parallel_1/client.log: Global Timeout - Critical: =
sched-mem-pressure/04-very_bloated_primary_both_tcp_mem_parallel_1/server.=
log: Global Timeout - Critical: sched-mem-pressure/05-slow_primary_both_tcp=
_mem_parallel_1/client.log: Global Timeout - Critical: =
sched-mem-pressure/05-slow_primary_both_tcp_mem_parallel_1/server.log: =
Global Timeout - Critical: sched-mem-pressure/06-balanced_both_tcp_mem_para=
llel_1/client.log: Global Timeout - Critical: sched-mem-pressure/06-balance=
d_both_tcp_mem_parallel_1/server.log: Global Timeout - Critical: =
sched-mem-pressure/07-very_bloated_primary_both_tcp_mem_parallel_10/client.=
log: Global Timeout - Critical: sched-mem-pressure/07-very_bloated_primary_=
both_tcp_mem_parallel_10/server.log: Global Timeout - Critical: =
sched-mem-pressure/08-slow_primary_both_tcp_mem_parallel_10/client.log: =
Global Timeout - Critical: sched-mem-pressure/08-slow_primary_both_tcp_mem_=
parallel_10/server.log: Global Timeout - Critical: sched-mem-pressure/09-ba=
lanced_both_tcp_mem_parallel_10/client.log: Global Timeout - Critical: =
sched-mem-pressure/09-balanced_both_tcp_mem_parallel_10/server.log: Global =
Timeout - Critical: sched-rmem/01-slow_primary_rmem_200/client.log: Global =
Timeout - Critical: sched-rmem/01-slow_primary_rmem_200/server.log: Global =
Timeout - Critical: sched-rmem/02-balanced_rmem_200/client.log: Global =
Timeout - Critical: sched-rmem/02-balanced_rmem_200/server.log: Global =
Timeout - Critical: sched-rmem/03-huge_lat_primary_rmem_200/client.log: =
Global Timeout - Critical: sched-rmem/03-huge_lat_primary_rmem_200/server.=
log: Global Timeout - Critical: sched-rmem/04-bloated_primary_rmem_200/clie=
nt.log: Global Timeout - Critical: sched-rmem/04-bloated_primary_rmem_200/s=
erver.log: Global Timeout - Critical: sched-rmem/05-slow_primary_rmem_800/c=
lient.log: Global Timeout - Critical: sched-rmem/05-slow_primary_rmem_800/s=
erver.log: Global Timeout - Critical: sched-rmem/06-balanced_rmem_800/clien=
t.log: Global Timeout - Critical: sched-rmem/06-balanced_rmem_800/server.=
log: Global Timeout - Critical: sched-rmem/07-huge_lat_primary_rmem_800/cli=
ent.log: Global Timeout - Critical: sched-rmem/07-huge_lat_primary_rmem_800=
/server.log: Global Timeout - Critical: sched-rmem/08-bloated_primary_rmem_=
800/client.log: Global Timeout - Critical: sched-rmem/08-bloated_primary_rm=
em_800/server.log: Global Timeout - Critical: sched-rmem/09-slow_primary_rm=
em_2000/client.log: Global Timeout - Critical: sched-rmem/09-slow_primary_r=
mem_2000/server.log: Global Timeout - Critical: sched-rmem/10-balanced_rmem=
_2000/client.log: Global Timeout - Critical: sched-rmem/10-balanced_rmem_20=
00/server.log: Global Timeout - Critical: sched-rmem/11-huge_lat_primary_rm=
em_2000/client.log: Global Timeout - Critical: sched-rmem/11-huge_lat_prima=
ry_rmem_2000/server.log: Global Timeout - Critical: =
sched-rmem/12-bloated_primary_rmem_2000/client.log: Global Timeout - =
Critical: sched-rmem/12-bloated_primary_rmem_2000/server.log: Global =
Timeout - Critical: sched-rmem/13-slow_primary_rmem_6000/client.log: Global=
 Timeout - Critical: sched-rmem/13-slow_primary_rmem_6000/server.log: =
Global Timeout - Critical: sched-rmem/14-balanced_rmem_6000/client.log: =
Global Timeout - Critical: sched-rmem/14-balanced_rmem_6000/server.log: =
Global Timeout - Critical: sched-rmem/15-huge_lat_primary_rmem_6000/client.=
log: Global Timeout - Critical: sched-rmem/15-huge_lat_primary_rmem_6000/se=
rver.log: Global Timeout - Critical: sched-rmem/16-bloated_primary_rmem_600=
0/client.log: Global Timeout - Critical: sched-rmem/16-bloated_primary_rmem=
_6000/server.log: Global Timeout - Critical: sched-serverlim/01-slow_primar=
y_bw_5_burst_10/client.log: Global Timeout - Critical: =
sched-serverlim/01-slow_primary_bw_5_burst_10/server.log: Global Timeout - =
Critical: sched-serverlim/02-balanced_bw_5_burst_10/client.log: Global =
Timeout - Critical: sched-serverlim/02-balanced_bw_5_burst_10/server.log: =
Global Timeout - Critical: sched-serverlim/03-huge_lat_primary_bw_5_burst_1=
0/client.log: Global Timeout - Critical: sched-serverlim/03-huge_lat_primar=
y_bw_5_burst_10/server.log: Global Timeout - Critical: =
sched-serverlim/04-slow_secondary_bw_5_burst_10/client.log: Global Timeout =
- Critical: sched-serverlim/04-slow_secondary_bw_5_burst_10/server.log: =
Global Timeout - Critical: sched-serverlim/05-slow_primary_bw_5_burst_250/c=
lient.log: Global Timeout - Critical: sched-serverlim/05-slow_primary_bw_5_=
burst_250/server.log: Global Timeout - Critical: sched-serverlim/06-balance=
d_bw_5_burst_250/client.log: Global Timeout - Critical: =
sched-serverlim/06-balanced_bw_5_burst_250/server.log: Global Timeout - =
Critical: sched-serverlim/07-huge_lat_primary_bw_5_burst_250/client.log: =
Global Timeout - Critical: sched-serverlim/07-huge_lat_primary_bw_5_burst_2=
50/server.log: Global Timeout - Critical: sched-serverlim/08-slow_secondary=
_bw_5_burst_250/client.log: Global Timeout - Critical: =
sched-serverlim/08-slow_secondary_bw_5_burst_250/server.log: Global Timeout=
 - Critical: sched-serverlim/09-slow_primary_bw_10_burst_10/client.log: =
Global Timeout - Critical: sched-serverlim/09-slow_primary_bw_10_burst_10/s=
erver.log: Global Timeout - Critical: sched-serverlim/10-balanced_bw_10_bur=
st_10/client.log: Global Timeout - Critical: sched-serverlim/10-balanced_bw=
_10_burst_10/server.log: Global Timeout - Critical: =
sched-serverlim/11-huge_lat_primary_bw_10_burst_10/client.log: Global =
Timeout - Critical: sched-serverlim/11-huge_lat_primary_bw_10_burst_10/serv=
er.log: Global Timeout - Critical: sched-serverlim/12-slow_secondary_bw_10_=
burst_10/client.log: Global Timeout - Critical: sched-serverlim/12-slow_sec=
ondary_bw_10_burst_10/server.log: Global Timeout - Critical: =
sched-serverlim/13-slow_primary_bw_10_burst_250/client.log: Global Timeout =
- Critical: sched-serverlim/13-slow_primary_bw_10_burst_250/server.log: =
Global Timeout - Critical: sched-serverlim/14-balanced_bw_10_burst_250/clie=
nt.log: Global Timeout - Critical: sched-serverlim/14-balanced_bw_10_burst_=
250/server.log: Global Timeout - Critical: sched-serverlim/15-huge_lat_prim=
ary_bw_10_burst_250/client.log: Global Timeout - Critical: =
sched-serverlim/15-huge_lat_primary_bw_10_burst_250/server.log: Global =
Timeout - Critical: sched-serverlim/16-slow_secondary_bw_10_burst_250/clien=
t.log: Global Timeout - Critical: sched-serverlim/16-slow_secondary_bw_10_b=
urst_250/server.log: Global Timeout - Critical: sched-serverlim/17-slow_pri=
mary_bw_50_burst_10/client.log: Global Timeout - Critical: =
sched-serverlim/17-slow_primary_bw_50_burst_10/server.log: Global Timeout -=
 Critical: sched-serverlim/18-balanced_bw_50_burst_10/client.log: Global =
Timeout - Critical: sched-serverlim/18-balanced_bw_50_burst_10/server.log: =
Global Timeout - Critical: sched-serverlim/19-huge_lat_primary_bw_50_burst_=
10/client.log: Global Timeout - Critical: sched-serverlim/19-huge_lat_prima=
ry_bw_50_burst_10/server.log: Global Timeout - Critical: =
sched-serverlim/20-slow_secondary_bw_50_burst_10/client.log: Global Timeout=
 - Critical: sched-serverlim/20-slow_secondary_bw_50_burst_10/server.log: =
Global Timeout - Critical: sched-serverlim/21-slow_primary_bw_50_burst_250/=
client.log: Global Timeout - Critical: sched-serverlim/21-slow_primary_bw_5=
0_burst_250/server.log: Global Timeout - Critical: sched-serverlim/22-balan=
ced_bw_50_burst_250/client.log: Global Timeout - Critical: =
sched-serverlim/22-balanced_bw_50_burst_250/server.log: Global Timeout - =
Critical: sched-serverlim/23-huge_lat_primary_bw_50_burst_250/client.log: =
Global Timeout - Critical: sched-serverlim/23-huge_lat_primary_bw_50_burst_=
250/server.log: Global Timeout - Critical: sched-serverlim/24-slow_secondar=
y_bw_50_burst_250/client.log: Global Timeout - Critical: =
sched-serverlim/24-slow_secondary_bw_50_burst_250/server.log: Global =
Timeout - Critical: sched-serverlim/25-slow_primary_bw_10_burst_10_wmem_600=
0/client.log: Global Timeout - Critical: sched-serverlim/25-slow_primary_bw=
_10_burst_10_wmem_6000/server.log: Global Timeout - Critical: =
sched-serverlim/26-balanced_bw_10_burst_10_wmem_6000/client.log: Global =
Timeout - Critical: sched-serverlim/26-balanced_bw_10_burst_10_wmem_6000/se=
rver.log: Global Timeout - Critical: sched-serverlim/27-slow_primary_bw_50_=
burst_10_wmem_6000/client.log: Global Timeout - Critical: =
sched-serverlim/27-slow_primary_bw_50_burst_10_wmem_6000/server.log: Global=
 Timeout - Critical: sched-serverlim/28-balanced_bw_50_burst_10_wmem_6000/c=
lient.log: Global Timeout - Critical: sched-serverlim/28-balanced_bw_50_bur=
st_10_wmem_6000/server.log: Global Timeout - Critical: =
sched-weak-secondary/01-weak_secondary/client.log: Global Timeout - =
Critical: sched-weak-secondary/01-weak_secondary/server.log: Global Timeout=
 - Critical: sched-weak-secondary/02-bad_secondary/client.log: Global =
Timeout - Critical: sched-weak-secondary/02-bad_secondary/server.log: =
Global Timeout - Critical: sched-weak-secondary/03-far_secondary/client.=
log: Global Timeout - Critical: sched-weak-secondary/03-far_secondary/serve=
r.log: Global Timeout - Critical: sched-weak-secondary/04-bloated_secondary=
/client.log: Global Timeout - Critical: sched-weak-secondary/04-bloated_sec=
ondary/server.log: Global Timeout - Critical: sched-weak-secondary/05-bloat=
ed_slow_secondary/client.log: Global Timeout - Critical: =
sched-weak-secondary/05-bloated_slow_secondary/server.log: Global Timeout -=
 Critical: sched-weak-secondary/06-very_bloated_secondary/client.log: =
Global Timeout - Critical: sched-weak-secondary/06-very_bloated_secondary/s=
erver.log: Global Timeout - Critical: sched-weak-secondary/07-weak_secondar=
y_backup/client.log: Global Timeout - Critical: sched-weak-secondary/07-wea=
k_secondary_backup/server.log: Global Timeout - Critical: =
sched-weak-secondary/08-bad_secondary_backup/client.log: Global Timeout - =
Critical: sched-weak-secondary/08-bad_secondary_backup/server.log: Global =
Timeout - Critical: sched-weak-secondary/09-far_secondary_backup/client.=
log: Global Timeout - Critical: sched-weak-secondary/09-far_secondary_backu=
p/server.log: Global Timeout - Critical: sched-weak-secondary/10-bloated_se=
condary_backup/client.log: Global Timeout - Critical: =
sched-weak-secondary/10-bloated_secondary_backup/server.log: Global Timeout=
 - Critical: sched-weak-secondary/11-bloated_slow_secondary_backup/client.=
log: Global Timeout - Critical: sched-weak-secondary/11-bloated_slow_second=
ary_backup/server.log: Global Timeout - Critical: sched-weak-secondary/12-v=
ery_bloated_secondary_backup/client.log: Global Timeout - Critical: =
sched-weak-secondary/12-very_bloated_secondary_backup/server.log: Global =
Timeout =E2=9D=8C
- Task: https://github.com/multipath-tcp/mptcp_net-next/a=
ctions/runs/40839532103

Initiator: Patchew Applier
Commits: https://github.com/multipath-tcp/mptcp_net-next/commits/112bfcdcbb=
ca
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?=
series=3D1195994


If there are some issues, you can reproduce them using =
the same environment as
the one used by the CI thanks to a docker image, e.=
g.:

    $ cd [kernel source code]
    $ docker run -v "${PWD}:${PWD}:rw" =
-w "${PWD}" --privileged --rm -it \
        --pull always =
mptcp/mptcp-upstream-virtme-docker:latest \
        auto-normal

For more details:

    https://github.com/multipath-tcp/mptcp-upstream-virt=
me-docker


Please note that despite all the efforts that have been already=
 done to have a
stable tests suite when executed on a public CI like here, =
it is possible some
reported issues are not due to your modifications. =
Still, do not hesitate to
help us improve that ;-)

Cheers,
MPTCP GH Action bot
Bot operated by Matthieu Baerts (NGI0 =
Core)
