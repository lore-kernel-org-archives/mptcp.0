Content-Type: multipart/mixed; boundary="===============7653827956600141346=="
MIME-Version: 1.0
From: Mat Martineau <mathew.j.martineau at linux.intel.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Initial net-next merge
Date: Thu, 12 Apr 2018 14:43:08 -0700
Message-ID: <alpine.OSX.2.21.1804121346030.28008@pchaturv-mobl1.amr.corp.intel.com>
X-Status: 
X-Keywords:                  
X-UID: 538

--===============7653827956600141346==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable


Hello -

I've pushed a merge of mptcp_trunk and net-next to =

https://github.com/multipath-tcp/mptcp_net-next/commits/master . The =

intent (as discussed in the 05-April-2018 meeting) is to work toward an =

upstreamable implementation by:

  * Removing features and optimizations not strictly necessary for a =

baseline MPTCP server

  * Integrating architectural changes that are reviewed and accepted on =

this mailing list

  * Keeping up with net-next

While this repository is hosted on github, we will be conducting patch =

review on this mailing list (and not using the github pull request =

workflow).

I'll be handling the net-next merges and pushing those directly to the =

repository. In the future I will push proposed merges to a separate (TBD) =

branch and notify the mailing list before updating master so people have =

an opportunity to review the changes.


Specifics about this merge:

I did minimal conflict resolution in the merge commit itself, and made the =

build fixes and code changes in a follow-up commit.

There was a significant TCP change where GSO (generic segmentation =

offload) is now always enabled (see =

https://github.com/multipath-tcp/mptcp_net-next/commit/0a6b2a1dc2a2105f1782=
55fe495eb914b09cb37a) =

This led to some new assumptions, like only supporting CHECKSUM_PARTIAL =

skbs for TCP transmission.

Christoph, you might want to look at the checksum change in =

mptcp_skb_entail(). I did some simple tests with and without the DSS =

checksum enabled that seemed to work fine.

There may be opportunity to simplify mptcp_select_size() too, since the =

TCP select_size() has been cut down to only a few lines.  I kept the =

current MPTCP behavior for now.

--
Mat Martineau
Intel OTC

--===============7653827956600141346==--
